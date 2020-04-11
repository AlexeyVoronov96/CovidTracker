//
//  CovidAnnotation.swift
//  Covid-Tracker
//
//  Created by Алексей Воронов on 11.04.2020.
//  Copyright © 2020 Алексей Воронов. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class CovidAnnotation: NSObject, MKAnnotation {
    
     let title: String?
     let coordinate: CLLocationCoordinate2D
     
     init(title: String?, coordinate: CLLocationCoordinate2D) {
       self.title = title
       self.coordinate = coordinate
     }
}
