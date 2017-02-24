//
//  MapaLugaresFavoritosViewController.swift
//  App_IntroMapas
//
//  Created by formador on 24/2/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapaLugaresFavoritosViewController: UIViewController {
    
    //MARK: - Variables
    var locatManager = CLLocationManager()
    
    //MARK: - IBOutlets
    @IBOutlet weak var myTercerMapa: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if existeObjetoSeleccioando == -1{
            locatManager.delegate = self
            locatManager.desiredAccuracy = kCLLocationAccuracyBest
            locatManager.requestWhenInUseAuthorization()
            locatManager.startUpdatingLocation()
        }else{
            let customLat = NSString(string: customLugaresFavoritos[existeObjetoSeleccioando]["lat"]!).doubleValue
            let customLong = NSString(string: customLugaresFavoritos[existeObjetoSeleccioando]["long"]!).doubleValue
            
            let customLocation = CLLocationCoordinate2D(latitude: customLat, longitude: customLong)
            let region = MKCoordinateRegion(center: customLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            myTercerMapa.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = customLocation
            annotation.title = customLugaresFavoritos[existeObjetoSeleccioando]["name"]
            myTercerMapa.addAnnotation(annotation)
        }
        
        let actionGR = UILongPressGestureRecognizer(target: self, action: #selector(self.muestraLugarFavorito(_:)))
        actionGR.minimumPressDuration = 2
        myTercerMapa.addGestureRecognizer(actionGR)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Utils
    func muestraLugarFavorito(_ gesture : UIGestureRecognizer){
        
        if gesture.state == UIGestureRecognizerState.began{
            let puntoToque = gesture.location(in: myTercerMapa)
            let nuevaCoordenate = myTercerMapa.convert(puntoToque, toCoordinateFrom: myTercerMapa)
            let customLocation = CLLocation(latitude: nuevaCoordenate.latitude, longitude: nuevaCoordenate.longitude)
            
            CLGeocoder().reverseGeocodeLocation(customLocation, completionHandler: { (placemarks, error) in
                var calle = ""
                var numero = ""
                var customTitulo = ""
                if let customPlacemarks = placemarks?[0]{
                    if customPlacemarks.thoroughfare != nil{
                        calle = customPlacemarks.thoroughfare!
                    }
                    if customPlacemarks.subThoroughfare != nil{
                        numero = customPlacemarks.subThoroughfare!
                    }
                    customTitulo = "\(calle) \(numero)"
                }
                if customTitulo == ""{
                    customTitulo = "Punto añadido el \(Date())"
                }
                let annotation = MKPointAnnotation()
                annotation.coordinate = nuevaCoordenate
                annotation.title = customTitulo
                self.myTercerMapa.addAnnotation(annotation)
                
                customLugaresFavoritos.append(["name": customTitulo, "lat" : "\(nuevaCoordenate.latitude)", "long": "\(nuevaCoordenate.longitude)"])
            })
        }
    }
    
    

}

extension MapaLugaresFavoritosViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        let latitud = userLocation.coordinate.latitude
        let longitud = userLocation.coordinate.longitude
        let customLocation = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        let region = MKCoordinateRegion(center: customLocation, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        myTercerMapa.setRegion(region, animated: true)
    }
}



















