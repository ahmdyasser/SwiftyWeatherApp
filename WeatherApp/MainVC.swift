//
//  ViewController.swift
//  WeatherApp
//
//  Created by Mohamed Atallah on 10/11/2022.
//

import UIKit
import Alamofire

class MainVc: UIViewController {
    
    // MARK: - IBOutlets
    // IBActions and outlests should be private since they MUST NOT be accessed form any class but MainVc
    @IBOutlet private weak var cityNameTextField: UITextField!
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var getButton: UIButton!
    @IBOutlet private weak var adviceLabel: UILabel!
    
    // MARK: - Properties
    private let networkingManager = NetworkingManager()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preconfigureUI()
    }
    
    // MARK: - Actions
    @IBAction func getButtonClicked(_ sender: Any) {
        networkingManager.getWeather(of: cityNameTextField.text!) { result in
            switch result {
            case .success(let weather):
                self.cityNameLabel.text = weather.city
                self.tempLabel.text = String(format: "%.2f", weather.temperature)
                self.humidityLabel.text = "\(weather.humidity)"
                self.adviceLabel.text = "some kool advice"
                
                switch weather.weatherCase {
                case .sunny:
                    self.weatherImageView.image = UIImage(systemName: "cloud.snow")
                case .cloudy:
                    self.weatherImageView.image = UIImage(systemName: "cloud.rain.fill")
                case .snowy:
                    self.weatherImageView.image = UIImage(systemName: "sun.max.fill")
                }
                
            case .failure(let error):
               debugPrint(error)
            }
        }
    }
    
    func preconfigureUI() {
        getButton.layer.cornerRadius = 15
        activityIndicator.isHidden = true
        adviceLabel.text = ""
        cityNameLabel.text = ""
    }
}


// MARK: - Extensions
