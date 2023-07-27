
import SwiftUI

struct PollutionView: View {
    
    // @EnvironmentObject and @State varaibles here
    @EnvironmentObject var weatherModelData : ModelData
    
    @EnvironmentObject var airModelData: AirModelData
    
    var body: some View {
        
        ZStack {
            // Background Image rendering code here
            Image("background")
                .resizable()
                .opacity(0.6)
                .ignoresSafeArea()
            
            VStack {
                Text("\(weatherModelData.addressLocation.street), \(weatherModelData.addressLocation.city), \(weatherModelData.addressLocation.country)")
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)

                VStack {

        //          Temperature Info
                    VStack(spacing: 20) {
                        Text("\((Int)(weatherModelData.forecast!.current.temp))ºC")
                            .padding()
                            .font(.largeTitle)
                        
                        HStack {
                            
                            AsyncImage(
                                url: URL(string: "https://openweathermap.org/img/wn/\(weatherModelData.forecast!.current.weather[0].icon)@2x.png"),
                                content: { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 100, maxHeight: 100)
                                },
                                placeholder: {
                                    ProgressView()
                                }
                            )
                            
                            Text(weatherModelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)
                                .foregroundColor(.black)
                        } // HStack Async Image end
                        
                        HStack(spacing: 40) {

                            Text("High: \(String(format: "%.0f", weatherModelData.forecast?.daily[0].temp.max ?? 0))ºC")
                                .foregroundColor(.black)
                            
                            Text("Low: \(String(format: "%.0f", weatherModelData.forecast?.daily[0].temp.min ?? 0))ºC")
                                .foregroundColor(.black)
                        }
                        
                        Text("Feels Like: \((Int)(weatherModelData.forecast!.current.feelsLike))ºC")
                            .foregroundColor(.black)

                        
                    }
                    .padding()
                    
                    Text("Air Quality Data:")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    HStack(spacing: 10) {
                        
                        VStack(spacing: 10){
                            Image("so2")
                                .frame(width: 50, height: 50)
                                .padding()
                            Text("\(airModelData.airQuality?.list[0].components["so2"] ?? 0, specifier: "%.2f")")
                            
                        }
                        
                        VStack(spacing: 10){
                            Image("no")
                                .frame(width: 50, height: 50)
                                .padding()
                            Text("\(airModelData.airQuality?.list[0].components["no"] ?? 0, specifier: "%.2f")")
                            
                        }
                        
                        VStack(spacing: 10){
                            Image("voc")
                                .frame(width: 50, height: 50)
                                .padding()
                            Text("\(airModelData.airQuality?.list[0].components["co"] ?? 0, specifier: "%.2f")")
                            
                        }
                        
                        VStack(spacing: 10){
                            Image("pm")
                                .frame(width: 50, height: 50)
                                .padding()
                            Text("\(airModelData.airQuality?.list[0].components["pm2_5"] ?? 0, specifier: "%.2f")")
                            
                        }
                        
                    }
                    
                }
                
            }
            .foregroundColor(.black)
            .shadow(color: .black,  radius: 0.5)
            
        }
        .ignoresSafeArea(edges: [.top, .trailing, .leading])
        }
    }

    

