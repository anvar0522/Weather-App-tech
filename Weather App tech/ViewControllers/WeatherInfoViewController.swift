//
//  WeatherInfoViewController.swift
//  Weather App tech
//
//  Created by anvar on 12/04/22.
//

import UIKit
import SnapKit
import CoreLocation

class WeatherInfoViewController: UIViewController, CLLocationManagerDelegate {
    
    private var locationWeather: WeaetherLocation?
    let locationManager = CLLocationManager()
    var currentCoordinates: CLLocation?
    
    var countryLb: UILabel = .init()
    var CLb: UILabel = .init()
    var highestTemp: UILabel = .init()
    var lowestTemp: UILabel = .init()
    var weatherDescription: UILabel = .init()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
        setUpLabels()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpLocation()
    }
    
    private func setConstraints () {
        self.view.addSubviews([highestTemp,CLb,countryLb,lowestTemp,weatherDescription])
        countryLb.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.equalToSuperview().inset(130)
        }
        weatherDescription.snp.makeConstraints { make in
            make.top.equalTo(countryLb).inset(150)
            make.trailing.leading.equalToSuperview().inset(50)
        }
        CLb.snp.makeConstraints { make in
            make.top.equalTo(weatherDescription).inset(150)
            make.trailing.equalToSuperview().inset(140)
        }
        highestTemp.snp.makeConstraints { make in
            make.top.equalTo(CLb).inset(100)
            make.leading.equalToSuperview().inset(75)
        }
        lowestTemp.snp.makeConstraints { make in
            make.top.equalTo(CLb).inset(100)
            make.trailing.equalToSuperview().inset(75)
            
        }
    }
    private func setUpLabels () {
        countryLb.text =  "Загрузка..."
        countryLb.font = countryLb.font.withSize(25)
        CLb.text = "Загрузка..."
        CLb.font = countryLb.font.withSize(50)
        highestTemp.text = "Загрузка..."
        highestTemp.font = countryLb.font.withSize(20)
        lowestTemp.text = "Загрузка..."
        lowestTemp.font = countryLb.font.withSize(20)
        weatherDescription.text = "Загрузка..."
        weatherDescription.font = countryLb.font.withSize(40)
        
    }
    func setUpLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentCoordinates == nil {
            currentCoordinates = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    func requestWeatherForLocation() {
        guard let currentCoordinate = currentCoordinates else { return }
        let lon = currentCoordinate.coordinate.longitude
        let lat = currentCoordinate.coordinate.latitude
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=643af76231454dfa6de370101f37b7c4"
        NetworkManager.shared.fetch(dataType: WeaetherLocation.self, from: url) { result in
            switch result {
            case .success(let weather):
                self.locationWeather = weather
                print(weather)
                self.countryLb.text = weather.name
                self.CLb.text = "C:\((Int((Double(weather.main.temp)-273.15))))"
                self.highestTemp.text = "H:\((Int((Double(weather.main.tempMax)-273.15))))"
                self.lowestTemp.text = "L:\((Int((Double(weather.main.tempMin)-273.15))))"
                self.weatherDescription.text = weather.weather[0].weatherDescription
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach(addSubview)
    }
}
