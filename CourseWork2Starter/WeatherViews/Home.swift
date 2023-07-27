
import SwiftUI
import CoreLocation

struct Home: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @State var isSearchOpen: Bool = false
    @State  var userLocation: String = ""
    
    var body: some View {
        
        ZStack {
            Image("background2")
                .resizable()
                .opacity(0.6)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        print("before toggle isSearchOpen: \(isSearchOpen)")
                        self.isSearchOpen.toggle()
                        print("after toggle isSearchOpen: \(isSearchOpen)")
                    } label: {
                        Text("Change Location")
                            .bold()
                            .font(.system(size: 30))
                    }
                    .sheet(isPresented: $isSearchOpen) {
                        SearchView(isSearchOpen: $isSearchOpen)
                    }
                    .padding()
                    
                    Spacer()
                }
                
                Spacer()
                
                Text("\(modelData.addressLocation.street), \(modelData.addressLocation.city), \(modelData.addressLocation.country)")
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.time ))))
                    .formatted(.dateTime.year().hour().month().day()))
    
                .padding()
                .font(.largeTitle)
                .foregroundColor(.black)
                .shadow(color: .black, radius: 1)
                
                Spacer()
                
                VStack() {
                    Text("Temp: \((Int)(modelData.forecast!.current.temp))ºC")
                        .padding()
                        .font(.title2)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                    
                    
                    Text("Humidity: \(modelData.forecast!.current.humidity)%")
                        .padding()
                        .font(.title2)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                    
                    Text("Pressure: \(modelData.forecast!.current.pressure) hPa")
                        .padding()
                        .font(.title2)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                    
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
                        
                        Text("\(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)")
                            .padding()
                            .font(.title2)
                            .foregroundColor(.black)
                            .shadow(color: .black, radius: 0.5)
                    }
                }
                
            }
            .onAppear {
                Task.init {
//                    self.userLocation = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
//
//                    self.modelData.addressLocation = await getAddressFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                    
                    print("LAT: \(modelData.forecast!.lat), LONG: \(modelData.forecast!.lon)")
                    print("TEST STREET: \(modelData.addressLocation.street)")
                    
                }
                
            }
        }
    }
}
