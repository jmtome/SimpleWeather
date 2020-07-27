//
//  ViewController.swift
//  myWeather
//
//  Created by Juan Manuel Tome on 26/07/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    
    //MARK: - Properties
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()

    
    let search: UITextField! = {
        let tf = UITextField(frame: .zero)
        tf.textAlignment = .right
        tf.font = UIFont.systemFont(ofSize: 25, weight: .light)
        tf.clearButtonMode = .never
        tf.placeholder = "Search"
        tf.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        //tf.layer.opacity = 0.5
        tf.backgroundColor = .systemFill
        tf.autocapitalizationType = .words
        tf.returnKeyType = .go
        tf.isSecureTextEntry = false
        
        return tf
    }()
    let locationButton: UIButton! = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.tintColor = UIColor.init(named: "weatherColor")
        return button
    }()
    let searchButton: UIButton! = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.tintColor = UIColor.init(named: "weatherColor")
        return button
    }()
    let conditionImageView: UIImageView! = {
        let iv = UIImageView(image: UIImage(systemName: "sun.max"))
        iv.contentMode = .scaleAspectFit
        iv.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        iv.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 120).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 120).isActive = true
        iv.tintColor = UIColor.init(named: "weatherColor")
        
        return iv
    }()
    let tempLabel: UILabel! = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 80, weight: .black)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.text = "21"
        label.tintColor = UIColor.init(named: "weatherColor")
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        return label
    }()
    let degLabel: UILabel! = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 100, weight: .light)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.text = "°"
        label.tintColor = UIColor.init(named: "weatherColor")
        return label
    }()
    let celsiusLabel: UILabel! = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 100, weight: .light)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.text = "C"
        label.tintColor = UIColor.init(named: "weatherColor")
        return label
    }()
    let cityLabel: UILabel! = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.text = "London"
        label.tintColor = UIColor.init(named: "weatherColor")
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        return label
    }()
    let subHStackView: UIStackView! = {
        let sv = UIStackView(frame: .zero)
        sv.axis = .horizontal
        sv.spacing = 0
        sv.distribution = .fill
        sv.alignment = .fill
        sv.contentMode = .scaleToFill
        sv.translatesAutoresizingMaskIntoConstraints = false 
        return sv
    }()
    let hStackView: UIStackView! = {
        let sv = UIStackView(frame: .zero)
        sv.axis = .horizontal
        sv.spacing = 10
        sv.distribution = .fill
        sv.alignment = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.contentMode = .scaleToFill
        return sv
    }()
    let vStackView: UIStackView! = {
        let sv = UIStackView(frame: .zero)
        sv.axis = .vertical
        sv.spacing = 10
        sv.alignment = .center
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.contentMode = .scaleToFill
        return sv
    }()
    let emptyView: UIView! = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 460).isActive = true
        view.widthAnchor.constraint(equalToConstant: 240).isActive = true
        return view
    }()
    let backgroundView: UIImageView! = {
        let iv = UIImageView(image: UIImage(named: "background2"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    override func loadView() {
        super.loadView()
        self.view.addSubview(backgroundView)
        backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.view.addSubview(vStackView)
        
        vStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        vStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        vStackView.addArrangedSubview(hStackView)
        hStackView.addArrangedSubview(locationButton)
        locationButton.addTarget(self, action: #selector(locationPressed(_:)), for: .touchUpInside)
        hStackView.addArrangedSubview(search)
        hStackView.addArrangedSubview(searchButton)
        hStackView.leadingAnchor.constraint(equalTo: vStackView.leadingAnchor).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: vStackView.trailingAnchor).isActive = true
        vStackView.addArrangedSubview(conditionImageView)
        vStackView.addArrangedSubview(subHStackView)
        subHStackView.addArrangedSubview(tempLabel)
        subHStackView.addArrangedSubview(degLabel)
        subHStackView.addArrangedSubview(celsiusLabel)
        vStackView.addArrangedSubview(cityLabel)
        vStackView.addArrangedSubview(emptyView)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.addTarget(self, action: #selector(searchPressed(_:)), for: .touchUpInside)
        search.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Private Methods
    @objc private func searchPressed(_ sender: UIButton) {
        print(search.text!)
        search.endEditing(true)
    }

    @objc private func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }

}
//d4d9f30ef07c5020f79f84b38db84f52 
extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text!)
        search.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if var city = search.text {
            city = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            weatherManager.fetchWeather(cityName: city)
        }
        textField.text = ""
        //to delete textfield
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            let ac = UIAlertController(title: "No Text Found", message: "Insert some text", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return false
        }
    }
    
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat)
            print(lon)
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension WeatherViewController: WeatherManagerDelegate {
    func weatherDidUpdate(_ weathherManager: WeatherManager ,weather: WeatherModel) {
        print(weather.temperature!)
        DispatchQueue.main.async {
            self.tempLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName!)
            self.cityLabel.text = weather.cityName
        }
         
    }
    func didFailWithError(_ weatherManager: WeatherManager, error: Error) {
        print(error)
    }
}
