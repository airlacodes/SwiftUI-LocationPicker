//
//  LocationService.swift
//  LocationPicker
//
//  Created by Codeonomics on 20/01/2022.
//

import Foundation
import Combine
import MapKit

class MapKitLocationSearcher: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
   
    @Published var searchQuery = ""
    @Published var completions: [MKLocalSearchCompletion] = []
    var completer: MKLocalSearchCompleter
    var cancellable: AnyCancellable?
    private let MAX_DISPLAY_RESULTS = 8
    
    override init() {
        completer = MKLocalSearchCompleter()
        
        super.init()
        cancellable = $searchQuery.assign(to: \.queryFragment,
                                          on: self.completer)
        completer.delegate = self
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.completions = completer
            .results
            .enumerated()
            .compactMap{ $0.offset < MAX_DISPLAY_RESULTS ? $0.element : nil }
    }
    
    func fullLocationSearch(input: MKLocalSearchCompletion,
                            completion: @escaping (MKMapItem) -> Void) {
        let searchRequest = MKLocalSearch.Request(completion: input)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            completion(response.mapItems[0])
        }
    }
}

extension MKLocalSearchCompletion: Identifiable {}
