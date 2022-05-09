//
//  WeatherReportTableViewCell.swift
//  a3_anas_azbemat
//


import UIKit

class WeatherReportTableViewCell: UITableViewCell {

    // Outlet
    @IBOutlet weak var lblCityTime: UILabel!
    @IBOutlet weak var lblWindspeedDirection: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
