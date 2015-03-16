//
//  ViewController.swift
//  Stormy
//
//  Created by Javi Manzano on 15/03/2015.
//  Copyright (c) 2015 Javi Manzano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let apiKey = "7ea5a2ce3b52e2b2231f7f4926b88cb8"

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var refreshActivityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        refreshActivityIndicator.hidden = true
        getCurrentWeatherData()
    }

    func getCurrentWeatherData() {
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")!
        let forecastURL = NSURL(string: "51.583401,-0.222730", relativeToURL: baseURL)!

        let sharedSession = NSURLSession.sharedSession()

        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in

            if error == nil {
                let dataObject = NSData(contentsOfURL: location)!
                let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject, options: nil, error: nil) as NSDictionary

                let currentWeather = Current(weatherDictionary: weatherDictionary)

                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.temperatureLabel.text = "\(currentWeather.temperature)"
                    self.iconView.image = currentWeather.icon!
                    self.currentTimeLabel.text = "At \(currentWeather.currentTime!) it is"
                    self.humidityLabel.text = "\(currentWeather.humidity)"
                    self.precipitationLabel.text = "\(currentWeather.precipProbability)"
                    self.summaryLabel.text = "\(currentWeather.summary)"

                    self.hideRefreshAnimation()
                })
            } else {
                let networkIssueController = UIAlertController(title: "Error", message: "Unable to load data, there's a connectivity error.", preferredStyle: .Alert)

                let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                networkIssueController.addAction(okButton)

                self.presentViewController(networkIssueController, animated: true, completion: nil)

                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.hideRefreshAnimation()
                })
            }
        })
        downloadTask.resume()
    }

    @IBAction func refresh() {
        showRefreshAnimation()
        getCurrentWeatherData()
    }

    func showRefreshAnimation() {
        refreshActivityIndicator.hidden = false
        refreshActivityIndicator.startAnimating()
        refreshButton.hidden = true

    }

    func hideRefreshAnimation() {
        refreshButton.hidden = false
        refreshActivityIndicator.hidden = true
        refreshActivityIndicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }




}

