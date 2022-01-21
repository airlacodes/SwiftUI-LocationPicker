//
//  MainParent.swift
//  LocationPicker
//
//  Created by Codeonomics on 21/01/2022.
//

import Foundation
import SwiftUI
import MapKit
import Combine

struct MainParent: View {
    
    @State var presentingPicker = false
    @State var selectedlocation: MKMapItem?
    
    var body: some View {
        VStack {
            Button("present picker:", action: {
                presentingPicker = true
            })
        }.sheet(isPresented: $presentingPicker,
                onDismiss: nil,
                content: {
            LocationSearchView(selectedLocation: $selectedlocation,
                               isActive: $presentingPicker)
        }).onReceive(Just(selectedlocation), perform: { newValue in
            print("parent received value: ", newValue)
        })
    }
}

