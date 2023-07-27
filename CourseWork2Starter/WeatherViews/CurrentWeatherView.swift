import SwiftUI

struct CurrentWeatherView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var locationString: String = "No location"
    
    var body: some View {
        ZStack {
            // Background Image rendering code here
            Image("background2")
                .resizable()
                .opacity(0.6)
                .ignoresSafeArea()
            
            VStack {
                Text("\(modelData.addressLocation.street), \(modelData.addressLocation.city), \(modelData.addressLocation.country)")
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)

                VStack {

        //          Temperature Info
                    VStack(spacing: 20) {
                        Text("\((Int)(modelData.forecast!.current.temp))ºC")
                            .padding()
                            .font(.largeTitle)
                        
                        HStack {
                            
                            AsyncImage(
                                url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather[0].icon)@2x.png"),
                                content: { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 100, maxHeight: 100)
                                },
                                placeholder: {
                                    ProgressView()
                                }
                            )
                            
                            Text(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)
                                .foregroundColor(.black)
                        } // HStack Async Image end
                        
                        HStack(spacing: 40) {

                            Text("High: \(String(format: "%.0f", modelData.forecast?.daily[0].temp.max ?? 0))ºC")
                                .foregroundColor(.black)
                            
                            Text("Low: \(String(format: "%.0f", modelData.forecast?.daily[0].temp.min ?? 0))ºC")
                                .foregroundColor(.black)
                        }
                        
                        Text("Feels Like: \((Int)(modelData.forecast!.current.feelsLike))ºC")
                            .foregroundColor(.black)
                    }
                    .padding()
                    
                    VStack(spacing: 20) {
                        
                        HStack(spacing: 0) {
                            Text("Wind Speed: \((Int)(modelData.forecast!.current.windSpeed))m/s")
                                .padding()
                                .font(.title2)
                                .foregroundColor(.black)
                            
                            Text("Direction: \(convertDegToCardinal(deg: modelData.forecast!.current.windDeg))")
                                .padding()
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        
                        HStack(spacing: 5) {
                            Text("Humidity: \((Int)(modelData.forecast!.current.humidity))%")
                                .padding()
                                .font(.title2)
                                .foregroundColor(.black)
                            
                            Text("Pressure: \((Int)(modelData.forecast!.current.pressure)) hPg")
                                .padding()
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                    }
                    
                    HStack(){
                        Image(systemName: "sunset.fill")
                            .renderingMode(.original)
                        Text(Date(timeIntervalSince1970: TimeInterval(((modelData.forecast!.current.sunset ?? 0 ))))
                            .formatted(.dateTime.hour().minute()))
                        .font(.title2)
                        
                        Image(systemName: "sunrise.fill")
                            .renderingMode(.original)
                        Text(Date(timeIntervalSince1970: TimeInterval(((modelData.forecast!.current.sunrise ?? 0 ))))
                            .formatted(.dateTime.hour().minute()))
                        .font(.title2)
                    }
                    .padding()
                }
            }
            .foregroundColor(.black)
            .shadow(color: .black,  radius: 0.5)
        }
        .ignoresSafeArea(edges: [.top, .trailing, .leading])
    }
}
