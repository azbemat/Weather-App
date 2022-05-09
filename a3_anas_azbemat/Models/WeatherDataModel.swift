//
//  WeatherM.swift
//  a3_anas_azbemat
//


import Foundation

struct WeatherResponse: Codable{
    let current: Current
    
    enum CodingKeys: String, CodingKey {
        case current
    }

}

// Current object in weather JSON data
struct Current: Codable{
    let temperature:Double
    let windDirection:String
    let windSpeed:Double
    

    enum CodingKeys: String, CodingKey {
        case temperature = "temp_c"
        case windDirection = "wind_dir"
        case windSpeed = "wind_kph"
    }
    
}
