//
//  WeatherData.swift
//  myWeather
//
//  Created by Juan Manuel Tome on 26/07/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    var name: String?
    let main: Main?
    let weather: [Weather]?
}

struct Main: Decodable {
    var temp: Double?
}
struct Weather: Decodable {
    var id: Int?
    //in the openweathermap api, id has tables that relate to different weathers
    var description: String?
    
    
}
