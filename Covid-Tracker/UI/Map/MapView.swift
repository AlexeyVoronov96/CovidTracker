//
//  MapView.swift
//  Covid-Tracker
//
//  Created by Алексей Воронов on 11.04.2020.
//  Copyright © 2020 Алексей Воронов. All rights reserved.
//

import SwiftUI
import UIKit
import MapKit

class CovidAnnotation: NSObject, MKAnnotation {
    
     let title: String?
     let coordinate: CLLocationCoordinate2D
     
     init(title: String?, coordinate: CLLocationCoordinate2D) {
       self.title = title
       self.coordinate = coordinate
     }
}

struct MapView: UIViewRepresentable {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Country.entity(), sortDescriptors: [
        NSSortDescriptor(key: "confirmed", ascending: false)
    ]) var countries: FetchedResults<Country>
    
    func makeUIView(context: Context) -> MKMapView {
        return MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let annotations = countries
            .map { country -> CovidAnnotation in
                CovidAnnotation(title: country.name, coordinate: country.coordinates)
            }
        
        uiView.annotations.forEach { uiView.removeAnnotation($0) }
        uiView.addAnnotations(annotations)
    }
}
