//
//  WeatherCell.swift
//  Weather App tech
//
//  Created by anvar on 13/04/22.
//

import UIKit
import SnapKit

class WeatherCell: UITableViewCell {
    static let identifier = "cellID"
    var countryLb: UILabel = .init()
    var timeLb: UILabel = .init()
    var CLb: UILabel = .init()
    var highestTemp: UILabel = .init()
    var lowestTemp: UILabel = .init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(countryLb)
        addSubview(timeLb)
        addSubview(CLb)
        addSubview(highestTemp)
        addSubview(lowestTemp)
        
        configureCountryLb()
        configureClb()
        configureTimeLb()
        configureLowestTemp()
        configureHighestTemp()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCity(with to: City) {
        countryLb.text = to.name
    }
    func configureTime(from value: String) {
        timeLb.text = value
    }
    func configureTemp(from value: Double) {
    CLb.text = String(value)
    }
    
    func configureHighestTemp(from value: Double) {
    highestTemp.text = String(value)
    }
    func configureLowestTemp(from value: Double) {
    lowestTemp.text = String(value)
    }

    
    
    func configureCountryLb() {
        countryLb.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(17)
        }
        
    }
    func configureTimeLb() {
        timeLb.snp.makeConstraints { make in
            make.top.equalTo(countryLb).inset(30)
            make.leading.equalToSuperview().inset(17)
        }
        
        
        
    }
    
    func configureClb() {
        CLb.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(17)
            
        }
        }
    
    func configureHighestTemp() {
        highestTemp.snp.makeConstraints { make in
            make.top.equalTo(CLb).inset(30)
            make.trailing.equalToSuperview().inset(17)
        }
        
    }
    func configureLowestTemp() {
        lowestTemp.snp.makeConstraints { make in
            make.top.equalTo(highestTemp).inset(30)
            make.trailing.equalToSuperview().inset(17)
            
        }
        
    }
}
