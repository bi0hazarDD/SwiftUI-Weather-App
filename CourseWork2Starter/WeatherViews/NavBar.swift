
import SwiftUI

struct NavBar: View {
    
    var body: some View {
        TabView {
            Home()
                .tabItem{
                    Label("City", systemImage: "magnifyingglass")
                }
            CurrentWeatherView()
                .tabItem {
                    
                    Label("Weather Now", systemImage: "sun.max.fill")
                }
            
            HourlyView()
                .tabItem{
                    
                    Label("Hourly View", systemImage: "clock.fill")
                }
            ForecastView()
                .tabItem {
                    
                    Label("Forecast View", systemImage: "calendar")
                }
            PollutionView()
                .tabItem {
                    
                    Label("Pollution View", systemImage: "aqi.high")
                }
        }
        .onAppear {
            UITabBar.appearance().isTranslucent = false
        }
        
    }
        
}

