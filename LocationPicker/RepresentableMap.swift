//
//  RepresentableMap.swift
//  LocationPicker
//
//  Created by Codeonomics on 20/01/2022.
//

import Foundation
import MapKit
import UIKit
import SwiftUI

struct MapView: UIViewRepresentable {

    @Binding var centerLocationDisplay: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {}
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            parent.centerLocationDisplay = "\(mapView.centerCoordinate)"
        }

        func mapView(_ mapView: MKMapView,
                     didUpdate userLocation: MKUserLocation) {
            print("User location\(userLocation.coordinate)")
        }

        func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
            print("Map will start loading")
        }

        func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
            print("Map did finish loading")
        }

        func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
            print("Map will start locating user")
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
    }

    func makeUIView(context: Context) -> MKMapView {
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -37.8136, longitude: 144.9631), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = region
        mapView.showsScale = true
        mapView.setUserTrackingMode(MKUserTrackingMode.none,
                                    animated: true)
        mapView.userTrackingMode = .none

        mapView.showsUserLocation = true
        mapView.showsCompass = true
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
    }

    func testFunc()  {
        print("Toggle Compass")
    }
}
