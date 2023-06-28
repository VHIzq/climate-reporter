//
//  WeatherManager.swift
//  Clima
//
//  Created by VÍCTOR HUGO IZQUIERDO on 14/03/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=1a6f71509c2de654d92e845ebb0ae525&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        // 1. Create url
        if let url = URL(string: urlString) {
            // 2. Create url sessi on
            let session = URLSession(configuration: .default)
            // 3. Give a task to session
            let task = session.dataTask(with: url) { data, response, error in
                if error !=  nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            // 4. Start task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main?.temp)
            print(decodedData.weather![0].description)
        } catch {
            print(error)
        }
    }
}
