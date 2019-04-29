//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by user150412 on 4/1/19.
//  Copyright © 2019 user150412. All rights reserved.
//

import Foundation

class WeatherLocation: Codable{
    var name: String
    var coordinates: String
    
    init(name:String, coordinates: String){
        self.name = name
        self.coordinates = coordinates
    }
}
