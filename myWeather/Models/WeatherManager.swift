//
//  WeatherManager.swift
//  myWeather
//
//  Created by Juan Manuel Tome on 26/07/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherConstants {
    static let API_ROOT_URL = "https://api.openweathermap.org/data/2.5/weather?"
    static let API_KEY = 
    static let API_UNITS = "&units=metric"
    
    static let API_BASIC = API_ROOT_URL + API_KEY + API_UNITS
    
    
}

protocol WeatherManagerDelegate {
    func weatherDidUpdate(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ weatherManager: WeatherManager, error: Error)
}
struct WeatherManager {
    
    func fetchWeather(cityName: String) {
        let urlString = WeatherConstants.API_BASIC + "&q=\(cityName)" 
        print(urlString)
        performRequest(with: urlString)
        
    }
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = WeatherConstants.API_BASIC + "&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    var delegate: WeatherManagerDelegate?
    
    func performRequest(with urlString: String) {
        //1. create a url
        guard let url = URL(string: urlString) else { return }
        
        
        //2. create a urlsession
        let session = URLSession(configuration: .default)
        //3. give the session a task
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                self.delegate?.didFailWithError(self, error: error!)
                return
                
            }
            
            if let weather = self.parseJSON(data) {
                self.delegate?.weatherDidUpdate(self, weather: weather)
            }
        }
        
        //4. start the task
        task.resume()
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather![0].id!
            let temp = decodedData.main!.temp!
            let name = decodedData.name!
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            return weather
        } catch let error {
            print(error)
            delegate?.didFailWithError(self, error: error)
            return nil 
        }
    }
    
    
    
}
