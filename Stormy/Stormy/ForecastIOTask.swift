//
//  ForecastIOTask.swift
//  Stormy
//
//  Created by Javi Manzano on 16/03/2015.
//  Copyright (c) 2015 Javi Manzano. All rights reserved.
//

import Foundation

class ForecastIOTask {

    let apiKey: String
    let baseURL: NSURL
    var currentWeather: Current?

    // Default values for latitude and longitude in London
    var latitude = 51.500843
    var longitude = -0.124614

    init() {
        apiKey = "7ea5a2ce3b52e2b2231f7f4926b88cb8"
        baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")!
    }

    func getCurrentWeatherData(onTaskDone: () -> Void, onTaskError: () -> Void, latitude: Double, longitude: Double)
    {
        self.latitude = latitude
        self.longitude = longitude
        getData(onTaskDone, onTaskError: onTaskError)
    }

    func getCurrentWeatherData(onTaskDone: () -> Void, onTaskError: () -> Void)
    {
        getData(onTaskDone, onTaskError: onTaskError)
    }

    func getData(onTaskDone: () -> Void, onTaskError: () -> Void) {
        let sharedSession = NSURLSession.sharedSession()

        let forecastURL = NSURL(string: "\(self.latitude),\(self.longitude)", relativeToURL: baseURL)!

        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL, completionHandler: { (location: NSURL?, response: NSURLResponse?, error: NSError?) -> Void in

            if error == nil {
                let dataObject = NSData(contentsOfURL: location!)
                let weatherDictionary: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(dataObject!, options: [])) as! NSDictionary

                self.currentWeather = Current(weatherDictionary: weatherDictionary)

                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    onTaskDone()
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    onTaskError()
                })
            }
        })
        downloadTask.resume()
    }
}