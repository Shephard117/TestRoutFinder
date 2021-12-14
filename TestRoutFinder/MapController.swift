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
    
    var annotationsArray: [MKPointAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setConstrients()
        adressButton.addTarget(self, action: #selector(adressPressed), for: .touchUpInside)
        routeButton.addTarget(self, action: #selector(routePressed), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector((resetPressed)), for: .touchUpInside)
        
    }
    
    @objc func adressPressed() {
        alertAdress(titile: "Добавить адресс", placeholder: "Введите адрес") { (text) in
            self.setupPlacemark(with: text)
        }
    }
    
    @objc func routePressed() {
        for index in 0...annotationsArray.count - 2 {
            createRoute(from: annotationsArray[index].coordinate, to: annotationsArray[index + 1].coordinate)
        }
        
        mapView.showAnnotations(annotationsArray, animated: true)
    }
    
    @objc func resetPressed() {
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        annotationsArray = []
        routeButton.isHidden = true
        resetButton.isHidden = true
    }
    
    private func setupPlacemark(with adress: String) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(adress) { [self] placemarks, error in
            
            if let error = error {
                alerterror(title: "Error", message: error.localizedDescription)
                return
            }
                
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            
            let annotaion = MKPointAnnotation()    //создаем аннотацию
            annotaion.title = "\(adress)"
                
            guard let placemarkLocation = placemark?.location else { return }  //присваиваем координаты
            annotaion.coordinate = placemarkLocation.coordinate
            
            self.annotationsArray.append(annotaion)         //добавляем в массив аннотации
            
            if annotationsArray.count > 2 {
                routeButton.isHidden = false
                resetButton.isHidden = false
            }
            
            mapView.showAnnotations(annotationsArray, animated: true) //отображем аннотации на карте
        }
    }
    
    private func createRoute(from start: CLLocationCoordinate2D, to finish: CLLocationCoordinate2D) {
        
        let startLocation = MKPlacemark(coordinate: start)
        let finishLocation = MKPlacemark(coordinate: finish)
        
        let request = MKDirections.Request()              // создаем запрос с указанием начальной и конечной точки
        request.source = MKMapItem(placemark: startLocation)
        request.destination = MKMapItem(placemark: finishLocation)
        request.transportType = .walking
        request.requestsAlternateRoutes = true
        
        let direction = MKDirections(request: request)
        direction.calculate { [self] response, error in
            
            if let error = error {
                alerterror(title: "Error", message: error.localizedDescription)
                return
            }
            
            guard let response = response else {
                
                alerterror(title: "Error", message: "Маршрут недоступен")
                return
                
            }
            
            var minRoute = response.routes[0]
            for route in response.routes {
                print(route.distance)
                minRoute = (route.distance < minRoute.distance) ? route : minRoute
            }
            
            mapView.addOverlay(minRoute.polyline)
        }
    }
}


extension MapController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .green
        return render
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
