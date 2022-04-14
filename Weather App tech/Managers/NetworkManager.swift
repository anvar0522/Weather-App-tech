//
//  NetworkManager.swift
//  Weather App tech
//
//  Created by anvar on 12/04/22.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}


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
    func fetchLocationData(from url: String?, with completion: @escaping(WeaetherLocation) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let weatherLocation = try JSONDecoder().decode(WeaetherLocation.self, from: data)
                DispatchQueue.main.async {
                    completion(weatherLocation)
                }
            } catch let error {
                print(error)
            }
            
            
        }.resume()
    }
    func fetch<T: Decodable>(dataType: T.Type, from url: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    
}
