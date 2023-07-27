
import Foundation

// This view model classes is made up of 3 main published variables that are directly tied to the views and allows the user to display the following information:
// 1) Data from the JSON file, stored in forecast
// 2) Data from API response, stored in forecast

// addressLocation is an object of type AddressDetails that holds the street, city and country displayed on the views.
// the time is an integer that works directly with the intervalSince1970 method to calculate the current time today, given the amount of seconds that have passed since 1970. this is done in the constructor using 'current.dt'

class ModelData: ObservableObject {
    
    @Published var forecast: Forecast?
    @Published var addressLocation = AddressDetails(street: "", city: "", country: "")
    @Published var time: Int = 0
    
    let API_KEY = "b3d3630b1f8a4cd88b94bc7c0936b5d3"
    
    init() {
        self.forecast = load("london.json")
        let localTime = self.forecast?.current.dt ?? 0 * 1000
        let offsetTime = self.forecast?.timezoneOffset ?? 0 * 1000
        self.time = localTime + offsetTime
        Task {
            self.addressLocation = await getAddressFromLatLong(lat: forecast?.lat ?? 0, lon: forecast?.lon ?? 0)
        }
        
    }

    func loadData(lat: Double, lon: Double) async throws -> Forecast {
        
        let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=\(API_KEY)")
        let session = URLSession(configuration: .default)
        
        let (data, _) = try await session.data(from: url!)
        
        do {
            let forecastData = try JSONDecoder().decode(Forecast.self, from: data)
            DispatchQueue.main.async {
                self.forecast = forecastData
                let localTime = self.forecast?.current.dt ?? 0
                let offsetTime = self.forecast?.timezoneOffset ?? 0
                self.time = localTime + offsetTime
                print("FORECAST TIMEZONE: \(self.forecast?.timezoneOffset ?? 0)")
                // Updating the new address location in accordance with received Forecast response from API call, saving the new value to the published addressLocation var to use in views.
                Task {
                    self.addressLocation = await getAddressFromLatLong(lat: self.forecast?.lat ?? 0, lon: self.forecast?.lon ?? 0)
                }
                
            }
            
            return forecastData
        } catch {
            throw error
        }
    }
    
    func load<Forecast: Decodable>(_ filename: String) -> Forecast {
        
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Forecast.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Forecast.self):\n\(error)")
        }
    }
}
