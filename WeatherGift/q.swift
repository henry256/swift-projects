//
//  WeatherDetail.swift
//  WeatherGift
//
//  Created by user150412 on 3/25/19.
//  Copyright © 2019 user150412. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherDetail: WeatherLocation{
    
    struct DailyForecast{
        var dailyMaxTemp: Double
        var dailyMinTemp: Double
        var dailyDate: Double
        var dailySummary: String
        var dailyIcon:String
    }
    
    struct HourlyForecast{
        var hourlyTime:Double
        var hourlyTemp:Double
        var hourlyPrecip:Double
        var hourlyIcon: String
    }
    var currentTemp="--"
    var currentSummary=""
    var currentIcon=""
    var currentTime = 0.0
    var timeZone = ""
    var DailyForecastArray = [DailyForecast]()
    var HourlyForcastArray = [HourlyForecast]()
    
    func getWeather(completed: @escaping () -> ()){
        let weatherURL = urlBase + urlAPIKey + coordinates
        
        AF.request(weatherURL).responseJSON{response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                if let temperature = json["currently"]["temperature"].double{
                    
                    let roundedTemp = String(format:"%3.f", temperature)
                    self.currentTemp = roundedTemp + "°"
                }else{
                    print("Could not return temp")
                }
                if let summary = json["daily"]["summary"].string{
                    self.currentSummary = summary
                }else{
                    print("Could not return summary")
                }
                if let icon = json["currently"]["icon"].string{
                    self.currentIcon = icon
                }else{
                    print("Could not return icon")
                }
                if let timeZone = json["timezone"].string{
                    self.timeZone = timeZone
                }else{
                    print("Could not return timezone")
                }
                if let time = json["currently"]["time"].double{
                    self.currentTime = time
                }else{
                    print("Could not return a time")
                }
                
                let dailyDataArray = json["daily"]["data"]
                self.DailyForecastArray=[]
                let days = min(7, dailyDataArray.count - 1)
                for day in 1...days{
                    let maxTemp = json["daily"]["data"][day]["temperatureHigh"].doubleValue
                    let minTemp = json["daily"]["data"][day]["temperatureLow"].doubleValue
                    let dateValue = json["daily"]["data"][day]["time"].doubleValue
                    let icon = json["daily"]["data"][day]["icon"].stringValue
                    let summary = json["daily"]["data"][day]["summary"].stringValue
                    let newDailyForecast = DailyForecast(dailyMaxTemp: maxTemp, dailyMinTemp: minTemp, dailyDate: dateValue, dailySummary: summary, dailyIcon: icon)
                    self.DailyForecastArray.append(newDailyForecast)
                }
                let hourlyDataArray = json["hourly"]["data"]
                self.HourlyForcastArray=[]
                let hours = min(24, hourlyDataArray.count - 1)
                for hour in 1...hours{
                    let hourlyTime = hourlyDataArray[hour]["time"].doubleValue
                    let hourlyTemp = hourlyDataArray[hour]["temperature"].doubleValue
                    let hourlyPrecip = hourlyDataArray[hour]["precipProbability"].doubleValue
                    let hourlyIcon = hourlyDataArray[hour]["icon"].stringValue
                    let newHourlyForecast = HourlyForecast(hourlyTime: hourlyTime, hourlyTemp: hourlyTemp, hourlyPrecip: hourlyPrecip, hourlyIcon: hourlyIcon)
                    self.HourlyForcastArray.append(newHourlyForecast)
                }
            
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}
