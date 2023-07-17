//
//  LocationManager.swift
//  Voyager
//
//  Created by Glenn Reinard Stanis on 20/05/23.
//

import CoreLocation
import MapKit

class LocationManager : NSObject, ObservableObject, CLLocationManagerDelegate, MKMapViewDelegate {
    private let clLocationManager = CLLocationManager()
    @Published var mapView = MKMapView()
    var userLocation = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    @Published var region = MKCoordinateRegion();
    var timer: Timer!
    
    override init() {
        super.init()
        clLocationManager.delegate = self
        clLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        clLocationManager.requestWhenInUseAuthorization()
        clLocationManager.startUpdatingLocation()
        clLocationManager.allowsBackgroundLocationUpdates = true
        mapView.delegate = self
        handleAlarmTriggered()
    }
    
    func goToUserLocation() {
        clLocationManager.startUpdatingLocation()
    }
    
    func startMonitoringGeofence(coordinate : CLLocationCoordinate2D) {
        let radius = 300.0
        let region = CLCircularRegion(center: coordinate, radius: radius, identifier: UUID().uuidString)
        
        region.notifyOnEntry = true
        region.notifyOnExit = true
        
        mapView.addOverlay(MKCircle(center: coordinate, radius: 300))
        clLocationManager.startMonitoring(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        //        let locationManager : LocationManager = LocationManager()
        //
        //        let latitude = -6.30219
        //        let longitude = 106.6499873
        //
        //        let latitude2 = -6.3053252
        //        let longitude2 = 106.6386437
        //
        //        let latitude3 = -6.2845625
        //        let longitude3 = 106.6331848
        //
        //        locationManager.startMonitoringGeofence(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        //        locationManager.startMonitoringGeofence(coordinate: CLLocationCoordinate2D(latitude: latitude2, longitude: longitude2))
        //        locationManager.startMonitoringGeofence(coordinate: CLLocationCoordinate2D(latitude: latitude3, longitude: longitude3))
        //
        print("Entered geofence!")
//        timer.fire()
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
            self.handleAchievement()
        }
        triggerAlarm(title: "You are entering a landmark", body: "Enjoy your visit") {
            print("Alarm has been triggered")
            provideHapticFeedback()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        //        let locationManager : LocationManager = LocationManager()
        //
        //        let latitude = -6.30219
        //        let longitude = 106.6499873
        //
        //        let latitude2 = -6.3053252
        //        let longitude2 = 106.6386437
        //
        //        let latitude3 = -6.2845625
        //        let longitude3 = 106.6331848
        //
        //        locationManager.startMonitoringGeofence(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        //        locationManager.startMonitoringGeofence(coordinate: CLLocationCoordinate2D(latitude: latitude2, longitude: longitude2))
        //        locationManager.startMonitoringGeofence(coordinate: CLLocationCoordinate2D(latitude: latitude3, longitude: longitude3))
        
        print("Exited geofence!")
        timer.invalidate()
        triggerAlarm(title: "You are exited a landmark", body: "See you next time!") {
            print("Custom function executed on alarm trigger")
            provideHapticFeedback()
        }
    }
    
    func triggerAlarm(title : String, body : String ,completion: (() -> Void)?) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = body
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 1,
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
        //        let content = UNMutableNotificationContent()
        //        content.title = title
        //        content.body = body
        //
        //        let request = UNNotificationRequest(identifier: "GeofenceNotification", content: content, trigger: nil)
        //        UNUserNotificationCenter.current().add(request) { error in
        //            if let error = error {
        //                print("Error scheduling geofence notification: \(error.localizedDescription)")
        //            } else {
        //                completion?() // Invoke the custom function or closure
        //            }
        //        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        mapView.setRegion(
            MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 1,
                longitudinalMeters: 1), animated: true
        )
        userLocation = location.coordinate
        clLocationManager.stopUpdatingLocation()
    }
    
    func handleAchievement() {
        print("Get achievement")
        triggerAlarm(title: "Congratulation", body: "You have visited the landmark") {
            print("Notification fired")
        }
    }
    
    func handleAlarmTriggered() {
        // Perform your custom actions here
        // let latitude = -6.3031785
        let latitude = -6.30219
        let longitude = 106.6499873
        
        let latitude2 = -6.3053252
        let longitude2 = 106.6386437
        
        let latitude3 = -6.2845625
        let longitude3 = 106.6331848
        
         startMonitoringGeofence(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        startMonitoringGeofence(coordinate: CLLocationCoordinate2D(latitude: latitude2, longitude: longitude2))
        startMonitoringGeofence(coordinate: CLLocationCoordinate2D(latitude: latitude3, longitude: longitude3))
        
        addCustomPin(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), title: "Green Office Park")
//        startMonitoringGeofence(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        
        addCustomPin(coordinate: CLLocationCoordinate2D(latitude: latitude2, longitude: longitude2), title: "AEON BSD")
//        startMonitoringGeofence(coordinate: CLLocationCoordinate2D(latitude: latitude2, longitude: longitude2))
//
        addCustomPin(coordinate: CLLocationCoordinate2D(latitude: latitude3, longitude: longitude3), title: "QBIG")
//        startMonitoringGeofence(coordinate: CLLocationCoordinate2D(latitude: latitude3, longitude: longitude3))
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
    
    func addCustomPin(coordinate: CLLocationCoordinate2D, title: String) {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = title
        mapView.addAnnotation(pin)
    }
}

//class ViewController



