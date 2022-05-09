//
//  Weather.swift
//  a3_anas_azbemat
//


import Foundation

class Weather {
    
    var temperature:Int;
    var windSpeed:Int;
    var windDirection:String;
    
    init(temperature:Int, windSpeed:Int, windDirection:String){
        self.temperature = temperature;
        self.windSpeed = windSpeed;
        self.windDirection = windDirection;
    }

}


