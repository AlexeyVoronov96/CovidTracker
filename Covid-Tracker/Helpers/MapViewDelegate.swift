//
//  MapViewDelegate.swift
//  Covid-Tracker
//
//  Created by Алексей Воронов on 11.04.2020.
//  Copyright © 2020 Алексей Воронов. All rights reserved.
//

import Foundation
import MapKit

final class MapViewDelegate: NSObject, MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let overlay = overlay as? MKCircle else { return MKOverlayRenderer() }
        
        let circleRenderer = MKCircleRenderer(circle: overlay)
        
        circleRenderer.fillColor = .systemOrange
        circleRenderer.strokeColor = .clear
        circleRenderer.alpha = 0.7
        
        return circleRenderer
    }
}
