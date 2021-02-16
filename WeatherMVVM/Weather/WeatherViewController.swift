//
//  ViewController.swift
//  WeatherMVVM
//
//  Created by Роман Чугай on 12.02.2021.
//

import UIKit
import MapKit


protocol ViewModelDelegate: class {
    func didLoadData()
}

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var rightNowView: RightNowView! 
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var forecastCollection: UICollectionView! {
        didSet {
            forecastCollection.delegate = self
            forecastCollection.dataSource = self
            forecastCollection.register(UINib(nibName: String(describing: WeatherViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: WeatherViewCell.self))
        }
        
    }
    
    private var city = ""
    private var locationManger: CLLocationManager!
    private var currentlocation: CLLocation?
    
    @IBAction func todayWeeklyValueChanged(_ sender: UISegmentedControl) {
        DispatchQueue.main.async {
            self.forecastCollection.reloadData()
        }
    }
    
    private var model: WheaterViewModelType = WeatherViewModel(dataSource: WheatherDataSource())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        self.model.loadWeatherModel()
        getLocation()
    }

    
    func getLocation() {
        if (CLLocationManager.locationServicesEnabled()) {
            locationManger = CLLocationManager()
            locationManger.delegate = self
            locationManger.desiredAccuracy = kCLLocationAccuracyBest
            locationManger.requestWhenInUseAuthorization()
            locationManger.requestLocation()
        }
        
    }
}
    extension WeatherViewController: CLLocationManagerDelegate {
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            self.currentlocation = location
            guard let location = self.currentlocation else {
                return
            }
            let latitude: Double = location.coordinate.latitude
            let longitude: Double = location.coordinate.longitude
            
            ServerManager.shared.setLatitude(latitude)
            ServerManager.shared.setLongitude(longitude)
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }
                if let placemarks = placemarks {
                    if placemarks.count > 0 {
                        let placemark = placemarks[0]
                        if let city = placemark.locality {
                            self.city = city
                            self.model.loadWeatherModel()
                        }
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error.localizedDescription)
    }

}

extension WeatherViewController: ViewModelDelegate {
    
    func didLoadData() {
        rightNowView.updateView(currentWeather: model.rows.current ?? Current(), city: city)
        DispatchQueue.main.async {
            self.forecastCollection.reloadData()
        }
    }
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
           return  model.rows.hourly.count
        }
        return  model.rows.daily.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WeatherViewCell.self), for: indexPath) as! WeatherViewCell
        if segmentedControl.selectedSegmentIndex == 0 {
            let item = model.rows.hourly[indexPath.row]
            cell.setupHourlyCell(item)
        } else {
            let item = model.rows.daily[indexPath.row]
            cell.setupDailyCell(item)
        }
       
        return cell
    }
    
}

extension WeatherViewController: UICollectionViewDelegate {
    
}
