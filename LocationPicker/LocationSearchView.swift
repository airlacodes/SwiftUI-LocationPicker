//
//  LocationSearchView.swift
//  LocationPicker
//
//  Created by Codeonomics on 20/01/2022.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation
import MapKit

struct LocationSearchView: View {
    
    @ObservedObject var locationSearcher: MapKitLocationSearcher = MapKitLocationSearcher()
    @Binding var selectedLocation: MKMapItem?
    @Binding var isActive: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            searchField.padding(20)
            Divider()
            if locationSearcher.searchQuery.isEmpty == false {
                searchResultsList
            } else {
                Spacer()
            }
        }.padding(.horizontal)
        .padding(.top)
        .ignoresSafeArea(edges: .bottom)
    }
    
    var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search Location", text: $locationSearcher.searchQuery)
                .disableAutocorrection(true)
                .autocapitalization(.words)
            if locationSearcher.searchQuery.isEmpty == false {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray).onTapGesture(perform: {
                        locationSearcher.searchQuery = ""
                    })
            }
        }
    }

    var searchResultsList: some View {
        List(locationSearcher.completions) { completion in
            VStack(alignment: .leading) {
                Text(completion.title)
                Text(completion.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }.onTapGesture(perform: {
                locationSearcher.fullLocationSearch(input: completion) { item in
                    self.selectedLocation = item
                    isActive = false
                }
            })
        }.listStyle(.plain)
    }
    
}
