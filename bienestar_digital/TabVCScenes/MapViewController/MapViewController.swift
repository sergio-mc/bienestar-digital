//
//  MapViewController.swift
//  bienestar_digital
//
//  Created by Sergio on 10/02/2020.
//  Copyright © 2020 sergio-mc. All rights reserved.
//

import Foundation
import MapKit


class MapViewController: UIViewController {
    
    var appsCSV: [DataModel] = []
    
    let annotation = MKPointAnnotation()
    
    // Función que al cargar la vista cargará los datos del csv convertido y por cada App añade un punto en el mapa
    override func viewDidLoad() {
        
        DataHelpers.loadFile()
        appsCSV = DataHelpers.parseCsvData()
        
        
        // set initial location in Honolulu
        
        for data in appsCSV
        {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: data.Latitude, longitude: data.Longitude)
            annotation.title = data.App
            mapView.addAnnotation(annotation)
        }

        
    }
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    
}
