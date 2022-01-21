//
//  LocationPickerView.swift
//  LocationPicker
//
//  Created by Codeonomics on 20/01/2022.
//

import Foundation
import SwiftUI
import MapKit

struct LocationPickerView: View {
    
    @State var displayLocation: String = ""
    @State var searchActive: Bool = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.50007773, longitude: -0.1246402) , span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))

    
    var body: some View {
        ZStack {
            MapView(centerLocationDisplay: $displayLocation).ignoresSafeArea()
            VStack {
                addressDisplaybar.padding(.top, 25).onTapGesture(perform: { searchActive = true })
                Spacer()
            }
            Image(systemName: "mappin").imageScale(.large)
        }.sheet(isPresented: $searchActive,
                onDismiss: nil,
                content: {
            LocationTextSearchView()
        })
    }
    
    var addressDisplaybar: some View {
        ZStack {
            Rectangle()
                .padding([.leading, .trailing], 25)
                .cornerRadius(15)
                .foregroundColor(.white)
                .shadow(radius: 10)
                .frame(maxHeight: 75)
            Text("Location: \(displayLocation)").font(.system(size: 16)).padding([.leading, .trailing], 25)
        }
    }
}
