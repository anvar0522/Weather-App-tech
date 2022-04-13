//
//  NetworkManager.swift
//  Weather App tech
//
//  Created by anvar on 12/04/22.
//

import Foundation

class NetworkManager {
    private init() {}
    
    static let shared = NetworkManager()
    func fetchData(from url: String?, with completion: @escaping(WeatherModel) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
                DispatchQueue.main.async {
                    completion(weatherModel)
                }
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
}
