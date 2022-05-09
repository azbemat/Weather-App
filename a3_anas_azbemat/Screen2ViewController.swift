//
//  Screen2ViewController.swift
//  a3_anas_azbemat
//

import UIKit

class Screen2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var reportList:[Report] = [];
    
    // Outlet
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        myTableView.dataSource = self
        myTableView.delegate = self

    }
    
    // MARK: Mandatory tableview functions
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportList.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for:indexPath) as! WeatherReportTableViewCell
            
        // get current report
        let currentReport = reportList[indexPath.row]
            
        // display the report
        cell.lblCityTime.text = "\(currentReport.city) at \(currentReport.savedTime)"
        cell.lblWindspeedDirection.text = "Wind: \(currentReport.windSpeed) Kph from \(currentReport.windDirection)"
        cell.lblTemperature.text = "\(currentReport.temperature)˚C"
            
        return cell
            
    }

    func numberOfSections(in tableView: UITableView) -> Int {
            return 1;
    }

}
