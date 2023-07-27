
import SwiftUI
import CoreLocation

struct SearchView: View {
    
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var airModelData: AirModelData
    
    @State var location = ""
    @State private var showAlert = false
    @State private var errorMessage = ""
    
    @Binding var isSearchOpen: Bool
    
    var body: some View {
        Spacer()
        ZStack {
            Color.teal
                .ignoresSafeArea()
            
            VStack{
                
                TextField("Enter New Location", text: self.$location, onCommit: {
                    CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
                        if let lat = placemarks?.first?.location?.coordinate.latitude,
                           let lon = placemarks?.first?.location?.coordinate.longitude {
                            print("\(lat), \(lon)")
                            Task {
                                do {
                                    modelData.forecast = try await modelData.loadData(lat: lat, lon: lon)
                                    airModelData.airQuality = try await airModelData.loadData(lat: lat, lon: lon)
                                } catch {
                                    print("SEARCH_VIEW_ERROR: \(error)")
                                    errorMessage = error.localizedDescription
                                    showAlert = true
                                }
                            }
                            isSearchOpen.toggle()
                        } else {
                            errorMessage = "Unable to find that location, please try again"
                            showAlert = true
                        }
                        
                    }//GEOCorder
                } //Commit
                )// TextField
                .padding(10)
                .shadow(color: .blue, radius: 10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Ariel", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                //.background(Color("background"))
                .cornerRadius(15) // TextField
                .autocorrectionDisabled()
            }//VStack
        }// Zstack
        Spacer()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Sorry, that's not right."), message: Text(errorMessage), dismissButton: .default(Text("Retry")) {
                    showAlert = false
                })
            }
    }// Some
} //View
