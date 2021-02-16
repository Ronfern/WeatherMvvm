//
//  RealmStorage.swift
//  WeatherMVVM
//
//  Created by Роман Чугай on 15.02.2021.
//

import RealmSwift

class RealmStorage: NSObject {
  
  static let sharedInstance = RealmStorage()
  private override init() {}
  
  lazy var uiRealm: Realm = {
    let uiRealm: Realm
    do {
      uiRealm = try Realm()
    } catch {
      let nserror = error as NSError
      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
    return uiRealm
  }()
  
}


