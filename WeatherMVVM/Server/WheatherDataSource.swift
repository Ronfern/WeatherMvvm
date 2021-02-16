//
//  WheatherDataSource.swift
//  WeatherMVVM
//
//  Created by Роман Чугай on 15.02.2021.
//

import UIKit

protocol WheatherDataSourceType {
    func fetchWeatherModel(completion: @escaping (WeatherModel) -> Void)
}

final class WheatherDataSource: WheatherDataSourceType {
    
    func fetchWeatherModel(completion: @escaping (WeatherModel) -> Void) {
        ServerManager.shared.listWheater { (response) in
            switch response.response?.statusCode {
            case 200?:
                if let data = response.data, let resultModel = try? JSONDecoder().decode(WeatherModel.self, from: data) {
                    resultModel.hourly.sort { (hour1: Hourly, hour2: Hourly) -> Bool in
                        return hour1.dt < hour2.dt
                    }
                    resultModel.daily.sort { (day1, day2) -> Bool in
                        return day1.dt < day2.dt
                    }

                    resultModel.writeToRealm()
                }
                completion(WeatherModel.all())
            default:
                completion(WeatherModel.all())
            }
        }
    }
}


