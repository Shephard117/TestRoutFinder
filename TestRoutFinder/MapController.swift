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
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstrients()
        
        adressButton.addTarget(self, action: #selector(adressTapped), for: .touchUpInside)
    }
    
    @objc func adressTapped() {
        print("Adress tapped")
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
            adressButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
