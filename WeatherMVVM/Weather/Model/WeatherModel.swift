//
//  WeatherModel.swift
//  WeatherMVVM
//
//  Created by Роман Чугай on 12.02.2021.
//

import RealmSwift

 final class WeatherModel: Object, Decodable {
    
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var lon: Double = 0.0
    @objc dynamic var timezone: String  = ""
    @objc dynamic var current: Current?
    var hourly = List<Hourly>()
    var daily  = List<Daily>()
    
    override class func primaryKey() -> String? {
        return "timezone"
    }
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon

        case timezone
        case current
        case hourly
        case daily
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat) ?? 0
        lon = try values.decodeIfPresent(Double.self, forKey: .lon) ?? 0
        current = try values.decodeIfPresent(Current.self, forKey: .current)
        hourly = try values.decodeIfPresent(List<Hourly>.self, forKey: .hourly) ?? List()
        daily = try values.decodeIfPresent(List<Daily>.self, forKey: .daily) ?? List()
    }
    
}



final class Current: Object, Decodable {
    @objc dynamic var dt: Int = 0
    @objc dynamic var sunrise: Int = 0
    @objc dynamic var sunset: Int = 0
    @objc dynamic var temp: Double = 0.0
    @objc dynamic var feels_like: Double = 0.0
    @objc dynamic var pressure: Int = 0
    @objc dynamic var humidity: Int = 0
    @objc dynamic var dew_point: Double = 0.0
    @objc dynamic var uvi: Double = 0.0
    @objc dynamic var clouds: Int = 0
    @objc dynamic var wind_speed: Double = 0.0
    @objc dynamic var wind_deg: Int = 0
    var weather = List<Weather>()

    
}

final class Weather: Object, Decodable {
    @objc dynamic var descriptionString: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var main: String = ""
    @objc dynamic var icon: String = ""
    
    enum CodingKeys: String, CodingKey {
        case description
        case id
        case main
        case icon
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        descriptionString = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        main = try values.decodeIfPresent(String.self, forKey: .main) ?? ""
        icon = try values.decodeIfPresent(String.self, forKey: .icon) ?? ""
    }
    

}

final class Hourly: Object, Decodable {
    @objc dynamic  var dt: Int = 0
    @objc dynamic  var temp: Double  = 0.0
    @objc dynamic  var feels_like: Double = 0.0
    @objc dynamic  var pressure: Int = 0
    @objc dynamic  var humidity: Int = 0
    @objc dynamic  var dew_point: Double = 0.0
    @objc dynamic  var clouds: Int = 0
    @objc dynamic  var wind_speed: Double = 0.0
    @objc dynamic  var wind_deg: Int = 0
    var weather = List<Weather>()

}

final class Daily: Object, Decodable {
    @objc dynamic var dt: Int = 0
    @objc dynamic var sunrise: Int = 0
    @objc dynamic var sunset: Int = 0
    @objc dynamic var temp: Temperature?
    @objc dynamic var feels_like: FeelsLike?
    @objc dynamic var pressure: Int = 0
    @objc dynamic var humidity: Int = 0
    @objc dynamic var dew_point: Double = 0.0
    @objc dynamic var wind_speed: Double = 0.0
    @objc dynamic var wind_deg: Int = 0
    var weather = List<Weather>()
    @objc dynamic var clouds: Int = 0
    @objc dynamic var uvi: Double = 0.0
    
    enum CodingKeys: String, CodingKey {
        case dt
        case sunrise
        case sunset
        case temp
        case feels_like
        case pressure
        case humidity
        case dew_point
        case wind_speed
        case wind_deg
        case weather
        case clouds
        case uvi
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
   
        dt = try values.decodeIfPresent(Int.self, forKey: .dt) ?? 0
        sunrise = try values.decodeIfPresent(Int.self, forKey: .sunrise) ?? 0
        sunset = try values.decodeIfPresent(Int.self, forKey: .sunset) ?? 0
        feels_like = try values.decodeIfPresent(FeelsLike.self, forKey: .feels_like)
        temp = try values.decodeIfPresent(Temperature.self, forKey: .temp)
        pressure = try values.decodeIfPresent(Int.self, forKey: .pressure) ?? 0
        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity) ?? 0
        
        dew_point = try values.decodeIfPresent(Double.self, forKey: .dew_point) ?? 0
        wind_speed = try values.decodeIfPresent(Double.self, forKey: .wind_speed) ?? 0
        weather = try values.decodeIfPresent(List<Weather>.self, forKey: .weather) ?? List()
        clouds = try values.decodeIfPresent(Int.self, forKey: .clouds) ?? 0
        uvi = try values.decodeIfPresent(Double.self, forKey: .uvi) ?? 0
   
    }

}

final class Temperature: Object, Decodable {
    
    @objc dynamic var day: Double = 0.0
    @objc dynamic var min: Double = 0.0
    @objc dynamic var max: Double = 0.0
    @objc dynamic var night: Double = 0.0
    @objc dynamic var eve: Double = 0.0
    @objc dynamic var morn: Double = 0.0
    
    enum CodingKeys: String, CodingKey {
        case day
        case min
        case max
        case night
        case eve
        case morn
    }
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        day = try values.decodeIfPresent(Double.self, forKey: .day) ?? 0.0
        min = try values.decodeIfPresent(Double.self, forKey: .min) ?? 0.0
        max = try values.decodeIfPresent(Double.self, forKey: .max) ?? 0.0
        night = try values.decodeIfPresent(Double.self, forKey: .night) ?? 0.0
        eve = try values.decodeIfPresent(Double.self, forKey: .eve) ?? 0.0
        morn = try values.decodeIfPresent(Double.self, forKey: .morn) ?? 0.0
    }
    
}

final class FeelsLike: Object, Decodable {
    @objc dynamic var day: Double = 0.0
    @objc dynamic var night: Double = 0.0
    @objc dynamic var eve: Double = 0.0
    @objc dynamic var morn: Double = 0.0
    
    enum CodingKeys: String, CodingKey {
        case day
        case night
        case eve
        case morn
    }
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        day = try values.decodeIfPresent(Double.self, forKey: .day) ?? 0.0
        night = try values.decodeIfPresent(Double.self, forKey: .night) ?? 0.0
        eve = try values.decodeIfPresent(Double.self, forKey: .eve) ?? 0.0
        morn = try values.decodeIfPresent(Double.self, forKey: .morn) ?? 0.0
    }
    

}
