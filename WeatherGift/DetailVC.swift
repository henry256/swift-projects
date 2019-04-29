//
//  DetailVC.swift
//  WeatherGift
//
//  Created by user150412 on 3/11/19.
//  Copyright © 2019 user150412. All rights reserved.
//

import UIKit
import CoreLocation

private let dateFormatter : DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat="EEEE, MMM dd, y"
    return dateFormatter
}()

class DetailVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var currentPage = 0
    var locationsArray = [WeatherLocation]()
    var locationDetail: WeatherDetail!
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        locationDetail = WeatherDetail(name: locationsArray[currentPage].name, coordinates:locationsArray[currentPage].coordinates)
        if currentPage != 0 {
            self.locationDetail.getWeather {
                self.updateUserInterface()
            }
        }
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if currentPage == 0{
            getLocation()
        }
    }
    func updateUserInterface(){
        locationLabel.text = locationDetail.name
        //let dateString = formatTimeForTimeZone(unixDate: location.currentTime, timeZone: location.timeZone)
        let dateString = locationDetail.currentTime.format(timeZone: locationDetail.timeZone, dateFormatter: dateFormatter)
        dateLabel.text = dateString
        temperatureLabel.text = locationDetail.currentTemp
        summaryLabel.text = locationDetail.currentSummary
        imageLabel.image = UIImage(named:locationDetail.currentIcon)
        tableView.reloadData()
        collectionView.reloadData()
        
    }
    func formatTimeForTimeZone(unixDate: TimeInterval, timeZone: String) -> String{
        let usableDate = Date(timeIntervalSince1970: unixDate)
        
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        let dateString = dateFormatter.string(from: usableDate)
        return dateString
    }

}
extension DetailVC: CLLocationManagerDelegate{
    
    func getLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
    }
    func handleLocationAuthorizeStatus(status: CLAuthorizationStatus){
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied:
            print("can't show location. User has not authorized its use")
        case .restricted:
            print("Access denied")
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleLocationAuthorizeStatus(status: status)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let geoCoder = CLGeocoder()
        var place = ""
        currentLocation = locations.last
        let currentLatitude = currentLocation.coordinate.latitude
        let currentLongitude = currentLocation.coordinate.longitude
        let currentCoodinates = "\(currentLatitude),\(currentLongitude)"
        geoCoder.reverseGeocodeLocation(currentLocation, completionHandler: {
            placemarks ,error in
            if placemarks != nil{
                let placemark = placemarks?.last
                place = (placemark?.name)!
            }
            else{
                print("error retrieving place")
                place = "Unknown weather location"
            }
            self.locationsArray[0].name = place
            self.locationsArray[0].coordinates = currentCoodinates
            self.locationDetail = WeatherDetail(name: place, coordinates: currentCoodinates)
            self.locationDetail.getWeather {
                self.updateUserInterface()
            }
                    })
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print ("failed to get user location")
        
    }
}

extension DetailVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationDetail.DailyForecastArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayWeatherCell", for: indexPath) as! DayWeatherCell
        let dailyForecast = locationDetail.DailyForecastArray[indexPath.row]
        let timeZone = locationDetail.timeZone
        cell.update(with:dailyForecast, timeZone:timeZone)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension DetailVC: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationDetail.HourlyForcastArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hourlyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourlyCell", for: indexPath) as! HourlyWeatherCell
        let hourlyForecast = locationDetail.HourlyForcastArray[indexPath.row]
        let timeZone = locationDetail.timeZone
        hourlyCell.update(with: hourlyForecast, timeZone:timeZone)
        return hourlyCell
    }
    
}
