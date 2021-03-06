//
//  Current.swift
//  Stormy
//
//  Created by Javi Manzano on 15/03/2015.
//  Copyright (c) 2015 Javi Manzano. All rights reserved.
//

import Foundation
import UIKit

struct Current {

    var currentTime: String?
    var temperature: Int
    var humidity: Double
    var precipProbability: Double
    var summary: String
    var icon: UIImage?

    init (weatherDictionary: NSDictionary) {
        let currentWeather = weatherDictionary["currently"] as! NSDictionary

        temperature = currentWeather["temperature"] as! Int
        humidity = currentWeather["humidity"] as! Double
        precipProbability = currentWeather["precipProbability"] as! Double
        summary = currentWeather["summary"] as! String

        let iconString = currentWeather["icon"] as! String
        icon = weatherIconFromString(iconString)

        let currentTimeIntValue = currentWeather["time"] as! Int
        currentTime = dateStringFromUnixtime(currentTimeIntValue)
    }

    func dateStringFromUnixtime(unixTime: Int) -> String {
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)

        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle

        return dateFormatter.stringFromDate(weatherDate)
    }

    func getTemperature() -> Int {
        var displayTemperature: Int = 0
        
        var units: String? = NSUserDefaults.standardUserDefaults().stringForKey("units")
        if units == nil {
            units = "celsius"
        }
        switch units! {
            case "celsius":
                displayTemperature = (temperature - 32) * 5/9
            case "fahrenheit":
                displayTemperature = temperature
            case "kelvin":
                displayTemperature = (temperature - 32) * 5/9 + 273
            default:
                displayTemperature = temperature
        }
        
        displayTemperature = (temperature - 32) * 5/9
        
        return displayTemperature
    }

    func weatherIconFromString(stringIcon: String) -> UIImage {
        var imageName: String

        switch stringIcon {
            case "clear-day":
                imageName = "clear-day"
            case "clear-night":
                imageName = "clear-night"
            case "rain":
                imageName = "rain"
            case "snow":
                imageName = "snow"
            case "sleet":
                imageName = "sleet"
            case "wind":
                imageName = "wind"
            case "fog":
                imageName = "fog"
            case "cloudy":
                imageName = "cloudy"
            case "partly-cloudy-day":
                imageName = "partly-cloudy"
            case "partly-cloudy-night":
                imageName = "cloudy-night"
            default:
                imageName = "default"
        }

        return UIImage(named: imageName)!
    }
}


