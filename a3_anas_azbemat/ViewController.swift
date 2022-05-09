//
//  ViewController.swift
//  a3_anas_azbemat
//


import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: Variables
    var savedReports:[Report] = []
    var currentCity = ""
    var currentTime = ""
    var currentWeather:Weather = Weather(temperature: 0, windSpeed: 0, windDirection: "")
    
    var locationManager:CLLocationManager!
    let geocoder = CLGeocoder()
    
    
    // MARK: Outlets
    @IBOutlet weak var lblTemperature: UILabel!
    
    @IBOutlet weak var lblSpeed: UILabel!
    
    @IBOutlet weak var lblDirection: UILabel!
    
    @IBOutlet weak var lblCity: UILabel!
    
    
    // MARK: VireDIdLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager = CLLocationManager()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        self.locationManager.delegate = self
    }
    
    // MARK: functions
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentPosition = locations.first{
            let latitude = currentPosition.coordinate.latitude
            let longitude = currentPosition.coordinate.longitude
                        
            self.getAddress(latitude:latitude, longitude: longitude)
                        
        }
    }
    
    
    private func getAddress(latitude:Double, longitude:Double) {

       
        if (latitude == nil || longitude == nil) {
            return
        }
           
        let location = CLLocation(latitude: latitude, longitude: longitude)
           
           
        self.geocoder.reverseGeocodeLocation(location) {
            (resultsList, error) in
            print("Sent request to geocoding service, waiting for response")
               
            // unsuccessful response from server
            if (error != nil) {
                print("Error occured during geocoding request")
                print(error)
                return
            }
               
            // successfull response from server
            if (resultsList != nil) {
                if (resultsList!.count == 0) {
                    print("No addresses found for this coordinate")
                }
                else {
                    let placemark:CLPlacemark = resultsList!.first!
                    print(placemark)
                       
                    self.currentCity = placemark.locality!
                       
                    self.getWeatherData()
                }
            }
        }
    }
    
    
    func getWeatherData() {
                        
        // connect to the API endpoint (url)
        let apiEndpoint = "https://api.weatherapi.com/v1/current.json?key=cab928995419488486932451222303&q=\(currentCity)&aqi=no"


            // convert string into a URL object
            guard let apiURL = URL(string:apiEndpoint) else {
                print("Error: Could not convert the string endpoint to an URL object")
                return
            }

            // fetch the data
            URLSession.shared.dataTask(with: apiURL) { (data, response, error) in

                // Validation
                if let err = error {
                    print("Error occured while fetching data from api")
                    print(err)
                    return
                }
                
                guard let data = data, error == nil else {
                    print("Error occured")
                    return
                }
                
                var json: WeatherResponse?
                do {
                    json = try JSONDecoder().decode(WeatherResponse.self, from: data)
                }
                catch {
                    print("An error occured during JSON decoding")
                    print(error)
                }

                guard let result = json else {
                    return
                }

                // extract the required information
                let currWindDirection = result.current.windDirection
                let currWindSpeed = Int(result.current.windSpeed)
                let currTemperature = Int(result.current.temperature)
                
                // Create weather object
                self.currentWeather = Weather(temperature: currTemperature, windSpeed: currWindSpeed, windDirection: currWindDirection)

                // Update user interface
                DispatchQueue.main.async {

                    self.lblDirection.text = "\(currWindDirection)"
                    self.lblSpeed.text = "\(currWindSpeed) Kph"
                    self.lblTemperature.text = "\(currTemperature)˚C"
                    self.lblCity.text = "\(self.currentCity)"

                }

            }.resume()

        }
   

    // MARK: Action Functions

    @IBAction func saveReportBtnPressed(_ sender: Any) {
        
        // get current time
        currentTime = getCurrentTime();

        // create report
        var newReport:Report = Report(weather: currentWeather, city: currentCity, savedTime: currentTime)
        
        // save the report
        savedReports.append(newReport)
            
    }
    
    @IBAction func seeHistoryBtnPressed(_ sender: Any) {
        print("Trying to obtain a programatic reference to screen #2")
                
                guard let screen2 = storyboard?.instantiateViewController(identifier: "screen2") as? Screen2ViewController else {
                           print("Cannot find a screen with an id of screen2")
                           return
               }
                         
                screen2.reportList = savedReports

                show(screen2, sender: self)
    }
    
    
    // MARK: Helper Function
    
    func getCurrentTime() -> String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"

        var currTime = formatter.string(from: Date())
        
        return currTime
    }
}

