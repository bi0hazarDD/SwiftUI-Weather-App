import SwiftUI

@main
struct CourseWork2StarterApp: App {
    
    @StateObject var weatherModelData = ModelData()
    @StateObject var airQualityModel = AirModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(weatherModelData)
                .environmentObject(airQualityModel)
        }
    }
}
