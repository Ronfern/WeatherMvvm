//
//  WeatherViewCell.swift
//  WeatherMVVM
//
//  Created by Роман Чугай on 15.02.2021.
//

import UIKit

class WeatherViewCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImage: FancyImage!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timeLabel.text = ""
        weatherImage.image = nil
        temperatureLabel.text = ""
    }
    
    func setupHourlyCell(_ model: Hourly) {
        
        let date = Date(timeIntervalSince1970: Double(model.dt))
        let hourString = Date.getHourFrom(date: date)
        let weatherIconName = model.weather.first?.icon
        let weatherTemperature = model.temp
        
        timeLabel.text = hourString
        weatherImage.image = UIImage(named: weatherIconName!)
        temperatureLabel.text = "\(Int(weatherTemperature.rounded()))°C"
    }
    func setupDailyCell(_ model: Daily) {
    
    let date = Date(timeIntervalSince1970: Double(model.dt))
    let dayString = Date.getDayOfWeekFrom(date: date)
        let weatherIconName = model.weather.first?.icon
        let weatherTemperature = model.temp?.day
    
        timeLabel.text = dayString
        weatherImage.image = UIImage(named: weatherIconName!)
        temperatureLabel.text = "\(Int(weatherTemperature!.rounded()))°C"
    }

}
