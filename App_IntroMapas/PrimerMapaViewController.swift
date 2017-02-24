//
//  PrimerMapaViewController.swift
//  App_IntroMapas
//
//  Created by formador on 17/2/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

enum MapaType : Int{
    case stardard = 0
    case hibrido = 1
    case satelite = 2
}

class PrimerMapaViewController: UIViewController {
    
    //MARK: - Variables locales
    var locationManager = CLLocationManager()
    
    //MARK: - IBOutlets
    @IBOutlet weak var mySegmentTipoMapa: UISegmentedControl!
    @IBOutlet weak var myPrimerMapa: MKMapView!
    @IBOutlet weak var myDescripcionDatosMapa: UILabel!
    
    
    //MARK: - IBACtions
    @IBAction func muestraMapa(_ sender: AnyObject) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.389925, longitude: -3.760911), span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        myPrimerMapa.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 40.389925, longitude: -3.760911)
        annotation.title = "Estamos en clase de iOS"
        annotation.subtitle = "Aqui currando hasta las 3 de la mañana"
        myPrimerMapa.addAnnotation(annotation)
    }
    
    @IBAction func muestraNuevoMapa(_ sender: AnyObject) {
        let mapa = MapaType(rawValue: mySegmentTipoMapa.selectedSegmentIndex)
        switch mapa! {
        case .stardard:
            myPrimerMapa.mapType = MKMapType.standard
        case .hibrido:
            myPrimerMapa.mapType = MKMapType.hybrid
        case .satelite:
            myPrimerMapa.mapType = MKMapType.satellite
            break
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DELEGADO DEL MAPA
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        //creamos un gesto de reconocimiento
        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(self.muestraGR(_:)))
        longPressGR.minimumPressDuration = 2
        myPrimerMapa.addGestureRecognizer(longPressGR)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Utils
    func muestraGR(_ gesture : UIGestureRecognizer){
        
        if gesture.state == UIGestureRecognizerState.began{
            let puntoTocado = gesture.location(in: myPrimerMapa)
            let nuevaCoordenada = myPrimerMapa.convert(puntoTocado, toCoordinateFrom: myPrimerMapa)
            let annotation = MKPointAnnotation()
            annotation.coordinate = nuevaCoordenada
            annotation.title = "Nueva etiqueta en el mapa"
            annotation.subtitle = "Aqui seguimos currando en iOS ya son las 4"
            myPrimerMapa.addAnnotation(annotation)
        }
        
    }
    
   
}

extension PrimerMapaViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.first!
        
        let latitud = userLocation.coordinate.latitude
        let longitud = userLocation.coordinate.longitude
        let latDelta = 0.001
        let longDelta = 0.001
        let location = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let region = MKCoordinateRegion(center: location, span: span)
        myPrimerMapa.setRegion(region, animated: true)
        myDescripcionDatosMapa.text = "\(userLocation)"
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = userLocation.coordinate
        annotation.title = "nueva etiqueta"
        annotation.subtitle = "seguimos en iOS"
        myPrimerMapa.addAnnotation(annotation)
        
        
        
        
    }
    
}














