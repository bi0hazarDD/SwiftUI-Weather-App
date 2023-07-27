
import Foundation
// Class is very similar to the weather viewmodel, however uses a diffrerent API link in order to retrieve air pollution data for a specific location using latitude and longtiude coorindates.

// The JSON data is initialized into a forecase using the load() method, and a local forecast property is used in order to load the JSON latitude and longitude values.
class AirModelData: ObservableObject {
    
    @Published var airQuality: AirQuality?
    
    private var forecast: Forecast?
    
    let API_KEY = "b3d3630b1f8a4cd88b94bc7c0936b5d3"
    
    init() { 
        self.forecast = load("london.json")
        Task {
            do {
                self.airQuality = try await loadData(lat: self.forecast!.lat, lon: self.forecast!.lon)
            } catch {
                print("AIRMODELDATA_FILE_ERROR: \(error)")
            }
        }
    }
    
    func loadData(lat: Double, lon: Double) async throws -> AirQuality {
        
        let url = URL(string:
                        "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&appid=\(API_KEY)")
        let session = URLSession(configuration: .default)

        let (data, _) = try await session.data(from: url!)

        do {
            //print(data)
            let airQualityData = try JSONDecoder().decode(AirQuality.self, from: data)
            DispatchQueue.main.async {
                
                self.airQuality = airQualityData
                print("AIR QUALITY LAT: \(String(describing: self.airQuality?.coord.lat))")
                print("AIR QUALITY LON: \(String(describing: self.airQuality?.coord.lon))")

            }

            return airQualityData
            
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
