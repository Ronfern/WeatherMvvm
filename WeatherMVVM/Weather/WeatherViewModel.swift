//
//  WeatherViewModel.swift
//  WeatherMVVM
//
//  Created by Роман Чугай on 15.02.2021.
//

import UIKit

protocol ViewModelType {
    func loadWeatherModel()
    func getWeatherModel() -> WeatherModel
    var delegate: ViewModelDelegate? { get set }
}

protocol  WheaterViewModelType: ViewModelType {
    var rows: WeatherModel  { get }
}


class WeatherViewModel: WheaterViewModelType {
   
    weak var delegate: ViewModelDelegate?
    var rows: WeatherModel = WeatherModel()
    
    let dataSource: WheatherDataSourceType
    
    init(dataSource: WheatherDataSourceType) {
        self.dataSource = dataSource
    }
    
    func loadWeatherModel() {
        dataSource.fetchWeatherModel { (result) in
            DispatchQueue.main.async {
                self.rows = result
                self.delegate?.didLoadData()
            }

        }
    }
    
    func getWeatherModel() -> WeatherModel {
       return rows
    }
    
}
