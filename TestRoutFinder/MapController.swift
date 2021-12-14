//
//  ViewController.swift
//  TestRoutFinder
//
//  Created by Дмитрий Скоробогаты on 14.12.2021.
//

import UIKit
import MapKit
import CoreLocation

class MapController: UIViewController {

    let mapView : MKMapView = {
       let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
        
    }()
    
    let adressButton: UIButton = {
       let button = UIButton()
        button.setTitle("Выбрать адрес", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let routeButton: UIButton = {
       let button = UIButton()
        button.setTitle("Проложить маршрут", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Очистить карту", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstrients()
        adressButton.addTarget(self, action: #selector(adressPressed), for: .touchUpInside)
        routeButton.addTarget(self, action: #selector(routePressed), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector((resetPressed)), for: .touchUpInside)
        
    }
    
    @objc func adressPressed() {
        alertAdress(titile: "Добавить адресс", placeholder: "Введите адрес") { (text) in
            print(text)
        }
    }
    
    @objc func routePressed() {
        print("Route pressed")
    }
    
    @objc func resetPressed() {
        print("Reset pressed")
    }
}

    


extension MapController {
    
    func setConstrients() {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        mapView.addSubview(adressButton)
        NSLayoutConstraint.activate([
            adressButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
            adressButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -30),
            adressButton.heightAnchor.constraint(equalToConstant: 30),
            adressButton.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        mapView.addSubview(routeButton)
        NSLayoutConstraint.activate([
            routeButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -50),
            routeButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 10),
            routeButton.heightAnchor.constraint(equalToConstant: 30),
            routeButton.widthAnchor.constraint(equalToConstant: 180)
        ])
        
        mapView.addSubview(resetButton)
        NSLayoutConstraint.activate([
            resetButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -50),
            resetButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            resetButton.heightAnchor.constraint(equalToConstant: 30),
            resetButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}
