//
//  MapViewController.swift
//  bienestar_digital
//
//  Created by Sergio on 10/02/2020.
//  Copyright © 2020 sergio-mc. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {

  // You don't need to modify the default init(nibName:bundle:) method.

  override func loadView() {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    view = mapView

    // Creates a marker in the center of the map.
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
    marker.title = "Sydney"
    marker.snippet = "Australia"
    marker.map = mapView
    
    let marker2 = GMSMarker()
    marker2.position = CLLocationCoordinate2D(latitude: 40.4167, longitude: -3.70325)
    marker2.title = "Madrid"
    marker2.snippet = "Madrid"
    marker2.map = mapView
  }
}
