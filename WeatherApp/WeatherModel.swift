//
//  Weather.swift
//  WeatherApp
//
//  Created by Ahmad Yasser on 12/11/2022.
//

import Foundation

struct WeatherModel {
    var city: String
    var weatherCase: WeatherCase
    var temperature: Double
    var humidity: Double
}

enum WeatherCase {
    case snowy
    case cloudy
    case sunny
}
