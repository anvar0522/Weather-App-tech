//
//  LocationWeatherModel.swift
//  Weather App tech
//
//  Created by anvar on 14/04/22.
//

import Foundation

struct WeaetherLocation:Codable {
    let coord: Coord
    let main: Main
    let name: String
    let weather: [WeatherElement]
}

struct Coord: Codable {
    let lon, lat : Double
}
struct Main: Codable {
    let temp, tempMin, tempMax:Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct WeatherElement: Codable {
    let weatherDescription: String
    
    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
    }
}
