// Structure obtained from the API response
import Foundation

// MARK: - AirQuality
struct AirQuality: Codable {
    let coord: Coord
    let list: [AirList]
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - AirList
struct AirList: Codable {
    let main: AirMain
    let components: [String: Double]
    let dt: Int
}

// MARK: - Main
struct AirMain: Codable {
    let aqi: Int
}
