//
//  Networking.swift
//  WeatherApp
//
//  Created by Ahmad Yasser on 11/11/2022.
//

import Alamofire

enum NetworkError: Error {
    case badURL
    // other possible cases
}
class NetworkingManager {
    func getWeather (of city: String, completion: @escaping (Result<WeatherModel, NetworkError>) -> Void) {
        
        let params = ["q": city, "appid": "8032c4d64bd00a5bd80d72917b57ad4b"]
        
        AF.request("https://api.openweathermap.org/data/2.5/weather", parameters: params, encoder: URLEncodedFormParameterEncoder.default).responseJSON { response in
            guard let result = response.value else { return }
            
            let JSON = result as! NSDictionary
            guard let main = JSON["main"] as? NSDictionary else { return }
            
            let humidity = main["humidity"] as! Double

            
            let fahrenheitTemperature = main["temp"] as! Double
            var measurement = Measurement(value: fahrenheitTemperature, unit: UnitTemperature.fahrenheit)
            measurement.convert(to: .celsius)
            let celsuisTemperature = measurement.value
            
            var weatherCase: WeatherCase = .sunny

            switch celsuisTemperature {
            case _ where celsuisTemperature < 10.0:
                weatherCase = .snowy
            case 10.0...20.0:
                weatherCase = .cloudy
            default:
                weatherCase = .sunny
            }
            
            let model = WeatherModel(city: city, weatherCase: weatherCase, temperature: celsuisTemperature, humidity: humidity)
            
            completion(.success(model))
            completion(.failure(.badURL))
        }
    }
}


