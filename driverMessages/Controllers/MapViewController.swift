//
//  MapViewController.swift
//  driverMessages
//
//  Created by DiuminPM on 21.11.2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var valueSlider = 0.1
    
    let myLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let myImage = UIImage(systemName: "location.circle")
        button.setImage(myImage, for: .normal)
        
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        button.tintColor = .buttonDark()
        return button
    }()
    
    var myLocation = true
    var radiusLocationLabel = UILabel()
    
    let locationRadiusSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 100
        return slider
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .purple
        setupMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationEnable()

    }
    
    func setupMapView() {
        mapView = MKMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
        
        view.addSubview(myLocationButton)
        myLocationButton.addTarget(self, action: #selector(locationPosition), for: .touchUpInside)
        myLocationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myLocationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            myLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            myLocationButton.heightAnchor.constraint(equalToConstant: 40),
            myLocationButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        locationRadiusSlider.addTarget(self, action: #selector(changeValueSlider), for: .valueChanged)
        radiusLocationLabel.text = "Радиус области карты: \(Int(valueSlider*10)) км"
        
        let locationView = SliderFormView(label: radiusLocationLabel, slider: locationRadiusSlider, button: myLocationButton)
        locationView.backgroundColor = UIColor(red: 115/255, green: 253/255, blue: 1, alpha: 0.5)
        locationView.layer.cornerRadius = 10
        view.addSubview(locationView)
        
        NSLayoutConstraint.activate([
            locationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            locationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            locationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
        
//        view.addSubview(locationRadiusSlider)
//        locationRadiusSlider.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            locationRadiusSlider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
//            locationRadiusSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            locationRadiusSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            locationRadiusSlider.heightAnchor.constraint(equalToConstant: 40),
//        ])
//
//        view.addSubview(radiusLocationLabel)
//        radiusLocationLabel.text = "Радиус области карты: \(Int(valueSlider*10)) км"
//        radiusLocationLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            radiusLocationLabel.bottomAnchor.constraint(equalTo: locationRadiusSlider.topAnchor, constant: -16),
//            radiusLocationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            radiusLocationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//        ])
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationEnable() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkAuthorization()
        }
        else {
            showAlerLocation(title: "У вас выключена служба геолокации", message: "Хотите включить?", url: URL(string: "App-Prefs:root=LOCATION_SERVICES"))
        }
    }
    
    func checkAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            break
        case .denied:
            showAlerLocation(title: "Запрет геолокации", message: "Хотите это изменить?", url: URL(string: UIApplication.openSettingsURLString))
            break
        case .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError()
        }
    }
    
    func showAlerLocation(title: String, message: String?, url: URL?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { alert in
            if let url = url {
                UIApplication.shared.open(url)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func locationPosition() {
        locationRadiusSlider.setValue(0, animated: true)
        valueSlider = 0.1
        radiusLocationLabel.text = "Радиус области карты: \(Int(valueSlider*10)) км"
        myLocation = true
    }
    
    @objc func changeValueSlider() {
        if locationRadiusSlider.value == 0 {
            valueSlider = 0.1
            radiusLocationLabel.text = "Радиус области карты: \(Int(valueSlider*10)) км"
            myLocation = true
        }
        else{
            valueSlider = Double(Int(locationRadiusSlider.value))
            radiusLocationLabel.text = "Радиус области карты: \(Int(valueSlider*10)) км"
            myLocation = true
            
        }
    }
    
}


extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if myLocation == true {
            if let location = locations.last?.coordinate {
                let region = MKCoordinateRegion(center: location, latitudinalMeters: CLLocationDistance(valueSlider*1000), longitudinalMeters: CLLocationDistance(valueSlider*10000))
                mapView.setRegion(region, animated: true)
                myLocation = false
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorization()
    }
}
