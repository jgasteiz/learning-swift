//
//  ViewController.swift
//  Stormy
//
//  Created by Javi Manzano on 15/03/2015.
//  Copyright (c) 2015 Javi Manzano. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var refreshActivityIndicator: UIActivityIndicatorView!

    var forecastIOTask = ForecastIOTask()
    var locationManager: CLLocationManager!
    var latitude: Double?
    var longitude: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshActivityIndicator.hidden = true

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

        getWeatherData()
    }

    @IBAction func refresh() {
        showRefreshAnimation()

        if latitude != nil && longitude != nil {
            getWeatherData(latitude!, longitude: longitude!)
        } else {
            getWeatherData()
        }
    }

    func getWeatherData() {
        forecastIOTask.getCurrentWeatherData(onGetWeatherDataSuccess, onTaskError: onGetWeatherDataError)
    }

    func getWeatherData(latitude: Double, longitude: Double) {
        forecastIOTask.getCurrentWeatherData(onGetWeatherDataSuccess, onTaskError: onGetWeatherDataError, latitude: latitude, longitude: longitude)
    }

    func onGetWeatherDataSuccess() {

        let currentWeather = self.forecastIOTask.currentWeather!

        self.temperatureLabel.text = "\(currentWeather.getTemperature())"
        self.iconView.image = currentWeather.icon!
        self.currentTimeLabel.text = "At \(currentWeather.currentTime!) it is"
        self.humidityLabel.text = "\(currentWeather.humidity)"
        self.precipitationLabel.text = "\(currentWeather.precipProbability)"
        self.summaryLabel.text = "\(currentWeather.summary)"

        self.hideRefreshAnimation()
    }

    func onGetWeatherDataError() {
        let networkIssueController = UIAlertController(title: "Error", message: "Unable to load data, there's a connectivity error.", preferredStyle: .Alert)

        let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
        networkIssueController.addAction(okButton)

        self.presentViewController(networkIssueController, animated: true, completion: nil)
        self.hideRefreshAnimation()
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

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {

        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in

            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }

            if placemarks!.count > 0 {
                 self.city.text = placemarks![0].locality
            } else {
                print("Problem with the data received from geocoder")
            }
        })

        latitude = manager.location!.coordinate.latitude
        longitude = manager.location!.coordinate.longitude
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error while updating location \(error.localizedDescription)")
    }

}

