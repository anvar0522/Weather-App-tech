//
//  WeatherModel.swift
//  Weather App tech
//
//  Created by anvar on 12/04/22.
//

import Foundation

struct WeatherModel: Codable {
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

