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
    override func viewDidLoad() {
        
        DataHelpers.loadFile()
        appsCSV = DataHelpers.parseCsvData()
        print("Hola soy el csv de mapas", appsCSV)
        
        
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
