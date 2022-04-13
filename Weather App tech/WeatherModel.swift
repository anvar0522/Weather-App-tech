//
//  WeatherModel.swift
//  Weather App tech
//
//  Created by anvar on 12/04/22.
//

import Foundation

struct WeatherModel: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]?
    let city: City
}
struct City:Codable {
    let id: Int
    let name: String
    let country: String
}

struct List: Codable {
    let dt: Int
    let main: MainClass
    let dtTxt: String
    enum CodingKeys: String, CodingKey {
            case dt, main
            case dtTxt = "dt_txt"
        }
//    let weather: [WeatherElement]
//    let clouds: Clouds
//    let wind: Wind
//    let rain: Rain?
}

struct MainClass:Codable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
            case temp
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
}
//}
//struct Rain:Codable {
//    let the3H: Double
//
//    enum CodingKeys: String, CodingKey{
//    case the3H = "3h"
//    }
//}
//
//struct WeatherElement: Codable {
//    let main: MainEnum
//    let weatherDescription: Description
//    let icon : String
//    enum CodingKeys: String, CodingKey{
//        case main
//        case weatherDescription = "description"
//        case icon
//    }

//    }
//enum MainEnum: String, Codable {
//    case clear = "Clear"
//    case clouds = "Clouds"
//    case rain = "Rain"
//}
//enum Description: String, Codable {
//    case brokenClouds = "broken clouds"
//    case clearSky = "clear sky"
//    case fewClouds = "few clouds"
//    case lightRain = "light rain"
//    case overcastClouds = "overcast clouds"
//    case scatteredClouds = "scattered clouds"
//}
//struct Wind: Codable {
//    let speed: Double
//}
//

