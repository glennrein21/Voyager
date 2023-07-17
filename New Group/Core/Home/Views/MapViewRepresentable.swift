//
//  MapViewRepresentable.swift
//  Voyager
//
//  Created by Glenn Reinard Stanis on 20/05/23.
//

import SwiftUI
import MapKit

struct MapViewRepresentable : UIViewRepresentable {
    
    @ObservedObject var locationManager: LocationManager

    func makeUIView(context: Context) -> MKMapView {
        locationManager.mapView.delegate = context.coordinator
        locationManager.mapView.isRotateEnabled = false
        locationManager.mapView.showsUserLocation = true
        locationManager.mapView.userTrackingMode = .follow
        return locationManager.mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        var circleRenderer = MKCircleRenderer()
        if let overlay = overlay as? MKCircle {
            circleRenderer = MKCircleRenderer(circle: overlay)
            circleRenderer.fillColor = UIColor.green
            circleRenderer.strokeColor = .black
            circleRenderer.alpha = 0.5
        }
        return circleRenderer
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    func addCustomPin() {
        let pin = MKPointAnnotation()
        
        pin.coordinate = locationManager.userLocation 
        pin.title = "You've been here"
        locationManager.mapView.addAnnotation(pin)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation : MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil }
        
        var annotationView = locationManager.mapView.dequeueReusableAnnotationView(withIdentifier: "LocationPin")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "LocationPin")
            annotationView?.canShowCallout = true
        }
        else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "LocationPin")
        return annotationView
    }
}

extension MapViewRepresentable {
    
    class MapCoordinator : NSObject, MKMapViewDelegate {
        let parent : MapViewRepresentable
        
        init(parent: MapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
    }
}
