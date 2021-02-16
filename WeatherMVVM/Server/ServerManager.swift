//
//  ServerManager.swift
//  WeatherMVVM
//
//  Created by Роман Чугай on 12.02.2021.
//

import Alamofire


class ServerManager {
    static let shared = ServerManager()
    private init() {}
    
    let URL_SAMPLE = "https://api.openweathermap.org/data/2.5/onecall?lat=60.99&lon=30.9&appid=89575d3c850c4fe09a01e9aedf6aec9e"
    let URL_API_KEY = "89575d3c850c4fe09a01e9aedf6aec9e"
    var URL_LATITUDE = "60.99"
    var URL_LONGITUDE = "30.0"
    var URL_GET_ONE_CALL = ""
    let URL_BASE = "https://api.openweathermap.org/data/2.5"
    
    let session = URLSession(configuration: .default)
    
    func buildURL() -> String {
        URL_GET_ONE_CALL = "/onecall?lat=" + URL_LATITUDE + "&lon=" + URL_LONGITUDE + "&units=metric" + "&appid=" + URL_API_KEY
        return URL_BASE + URL_GET_ONE_CALL
    }
    
    func setLatitude(_ latitude: String) {
        URL_LATITUDE = latitude
    }
    
    func setLatitude(_ latitude: Double) {
        setLatitude(String(latitude))
    }
    
    func setLongitude(_ longitude: String) {
        URL_LONGITUDE = longitude
    }
    
    func setLongitude(_ longitude: Double) {
        setLongitude(String(longitude))
    }
    
    
    func listWheater(completion: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(buildURL(), method: .get, parameters: nil, headers: nil).responseJSON(completionHandler: completion)
    }
}
