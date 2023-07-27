
import Foundation
import CoreLocation


// This method returns an object of address details by using CLPlacemark and CLGeocoder as well as CLLocation to get a general location given some latitude and longitude values (from the forecase property from the viewmodel).
// These values are then returned as an AddressDetails object and assigned tothe addressLocatino variable in the viewmodel.
func getAddressFromLatLong(lat: Double, lon: Double) async -> AddressDetails {
    
    var address: AddressDetails = AddressDetails(street: "N/A", city: "N/A", country: "N/A")
    var placemarks: [CLPlacemark]
    let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)

    let ceo: CLGeocoder = CLGeocoder()

    let loc: CLLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
    
    do {
        placemarks = try await ceo.reverseGeocodeLocation(loc)
        
        address = AddressDetails(street: placemarks[0].name ?? "No Street" , city: placemarks[0].locality ?? "No City" , country: placemarks[0].country ?? "No Country")
    } catch {
        print("Reverse geodecoe fail: \(error.localizedDescription)")
    }
    
    return address
}
