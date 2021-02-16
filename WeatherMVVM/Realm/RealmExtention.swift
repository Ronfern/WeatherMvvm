//
//  RealmExtention.swift
//  WeatherMVVM
//
//  Created by Роман Чугай on 15.02.2021.
//

import RealmSwift

extension WeatherModel {
    
    static func all(in realm: Realm = RealmStorage.sharedInstance.uiRealm) -> WeatherModel {
        return realm.objects(WeatherModel.self).first ?? WeatherModel()
    }
    
    func writeToRealm(in realm: Realm = RealmStorage.sharedInstance.uiRealm) {
        do {
            try realm.write {
                realm.add(self, update: .modified)
            }
        } catch let error {
            print("ERROR DELETING : \(error)")
        }
    }
}

