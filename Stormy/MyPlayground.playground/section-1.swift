// Playground - noun: a place where people can play

import UIKit

let apiKey = "7ea5a2ce3b52e2b2231f7f4926b88cb8"

let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")!
let forecastURL = NSURL(string: "51.583401,-0.222730", relativeToURL: baseURL)!

let weatherData = NSData(contentsOfURL: forecastURL)
