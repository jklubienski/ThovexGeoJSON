//
//  ViewController.swift
//  ThovexGeoJSON
//
//  Created by James on 07/03/2023.
//

import UIKit
import GoogleMaps
import GoogleMapsUtils

class ViewController: UIViewController {

    private var mapView: GMSMapView!
    private var renderer: GMUGeometryRenderer!
    private var geoJsonParser: GMUGeoJSONParser!
    
    let model = AppModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieves the maps api key from the .xconfig file and provides it to maps
        if let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String {
            GMSServices.provideAPIKey(apiKey)
        }
            
        //Setting up the mapView
        let camera = GMSCameraPosition.camera(withLatitude: 51.37135, longitude: -2.81018, zoom: 10.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view = mapView
    }
    
    // Retrieves and plots the GeoJSON data after map loads
    override func viewDidAppear(_ animated: Bool) {
        model.getGeoJSON() { completionHandler in
            self.plotGeoJSON(json: completionHandler)
        }
    }
    
    /// Plots the GeoJSON data on the mapView
    /// - Parameter json: GeoJSON data retrieved from the AppModel
    func plotGeoJSON(json:Data) {
        geoJsonParser = GMUGeoJSONParser(data: json)
        geoJsonParser.parse()
        
        renderer = GMUGeometryRenderer(map: mapView, geometries: geoJsonParser.features)
        renderer.render()
    }
}



     

