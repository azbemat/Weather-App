//
//  Report.swift
//  a3_anas_azbemat
//


import Foundation

class Report : Weather{
    
    var city:String;
    var savedTime:String;
    
    init(weather:Weather, city:String, savedTime:String){
        self.city = city
        self.savedTime = savedTime
        super.init(temperature: weather.temperature, windSpeed: weather.windSpeed, windDirection: weather.windDirection)
    }

}
