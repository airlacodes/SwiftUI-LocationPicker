//
//  LocationPickerView.swift
//  LocationPicker
//
//  Created by Codeonomics on 20/01/2022.
//

import Foundation
import SwiftUI
import MapKit
import Combine
struct PickOnMapView: View {
    
    @State var displayLocation: String = ""
    @State var searchActive: Bool = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.50007773, longitude: -0.1246402) , span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))

    @State var selectedLocation: MKMapItem?
    
    var body: some View {
        ZStack {
            MapView(locationDisplayOutput: $displayLocation,
                    searchedMapItem: $selectedLocation)
                .ignoresSafeArea()
            VStack {
                addressDisplaybar.padding(.top, 25).onTapGesture(perform: { searchActive = true })
                Spacer()
            }
            Image(systemName: "mappin").imageScale(.large)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .foregroundColor(.blue)
                        .frame(width: 75, height: 75)
                        .padding(.trailing, 50)
                        .padding(.bottom, 50)
                }
            }

        }
    }
    
    var addressDisplaybar: some View {
        ZStack {
            Rectangle()
                .padding([.leading, .trailing], 25)
                .cornerRadius(15)
                .foregroundColor(.white)
                .shadow(radius: 10)
                .frame(maxHeight: 75)
                Text("\(addressDisplayText())")
                    .font(.system(size: 16)).padding(.leading, 10)
                    .padding(.trailing, 25)
        }
    }
    
    func addressDisplayText() -> String {
        if let selectedLocation = selectedLocation?.name {
            return "\(selectedLocation)"
        } else {
            return "\(displayLocation)"
        }

    }
}
