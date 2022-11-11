//
//  ViewController.swift
//  WeatherApp
//
//  Created by Mohamed Atallah on 10/11/2022.
//

import UIKit
import Alamofire

class MainVc: UIViewController {
    
    var cityName = ""

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        getButton.layer.cornerRadius = 15
        activityIndicator.isHidden = true
        adviceLabel.text = ""
        cityNameLabel.text = ""
        
    }

    @IBAction func getButtonClicked(_ sender: Any) {
        
        cityName = cityNameTextField.text!
        getWetherByCityName()
        
    }
    
    func getWetherByCityName() {
        
        let params = ["q": cityName, "appid": "8032c4d64bd00a5bd80d72917b57ad4b"]
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        AF.request("https://api.openweathermap.org/data/2.5/weather", parameters: params, encoder: URLEncodedFormParameterEncoder.default).responseJSON { response in
            if let result = response.value {
                
                let JSON = result as! NSDictionary
                
                guard let main = JSON["main"] as? NSDictionary else {
                    let alert = UIAlertController(title: "Error!", message: "Wrong City Name", preferredStyle: .alert)
                    let closeAction = UIAlertAction(title: "OK", style: .default) { _ in
                        self.tempLabel.text = "-"
                        self.humidityLabel.text = "-"
                        self.cityNameLabel.text = ""
                        self.adviceLabel.text = ""
                        self.cityNameTextField.text = ""
                        self.weatherImageView.image = UIImage(systemName: "cloud.fill")
                    }
                    alert.addAction(closeAction)
                    self.present(alert, animated: true)
                    self.activityIndicator.isHidden = true
                    return
                }
                var temp = (main["temp"] as! Double) - 272.15
                temp = Double(round(1000 * temp) / 1000)
                let humidity = main["humidity"] as! Int
                
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.tempLabel.text = "\(temp)°"
                self.humidityLabel.text = "\(humidity)"
                self.cityNameLabel.text = self.cityName
                
                switch temp {
                case _ where temp < 10.0:
                    if let myImage = UIImage(systemName: "cloud.snow") {
                        let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                        self.weatherImageView.image = tintableImage
                    }
                    
                    self.weatherImageView.tintColor = UIColor.blue
                    self.adviceLabel.text = "Don't forget your Coat!"
                    self.tempLabel.tintColor = .blue
                case 10.0...20.0:
                    if let myImage = UIImage(systemName: "cloud.rain.fill") {
                        let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                        self.weatherImageView.image = tintableImage
                    }
                    
                    self.weatherImageView.tintColor = UIColor.white
                    self.adviceLabel.text = "Don't forget your Umbrella!"
                    self.tempLabel.tintColor = .white
                default:
                    if let myImage = UIImage(systemName: "sun.max.fill") {
                        let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                        self.weatherImageView.image = tintableImage
                    }
                    
                    self.weatherImageView.tintColor = UIColor.systemOrange
                    self.adviceLabel.text = "Don't forget your bottle of water! and ofcourse your sunglasses."
                    self.tempLabel.tintColor = .orange
                    
                }
                
            }
        }
        
    }
    
    func changImage() {
        
    }
    
}

