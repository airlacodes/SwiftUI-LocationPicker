//
//  LocationTextSearchView.swift
//  LocationPicker
//
//  Created by Codeonomics on 20/01/2022.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

struct LocationTextSearchView: View {
    
    @ObservedObject var betterLocationSearchService: LocationSearchService = LocationSearchService()

        var body: some View {
            VStack(alignment: .leading) {
                TextField("Enter City", text: $betterLocationSearchService.searchQuery)
                Divider()
                Text("Results")
                    .font(.title)
                List(betterLocationSearchService.completions) { completion in
                              VStack(alignment: .leading) {
                                  Text(completion.title)
                                  Text(completion.subtitle)
                                      .font(.subheadline)
                                      .foregroundColor(.gray)
                              }.onTapGesture(perform: {
                                  betterLocationSearchService.fullLocation(completion: completion)
                              })
                          }
            }
            .padding(.horizontal)
            .padding(.top)
            .ignoresSafeArea(edges: .bottom)
        }
}

extension LocationTextSearchView {
    class ViewModel: ObservableObject {
        

        init() {
        }
        
        
    }
}

