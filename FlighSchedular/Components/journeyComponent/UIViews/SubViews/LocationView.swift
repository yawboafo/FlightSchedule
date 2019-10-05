//
//  LocationView.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 05/10/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import MapKit
class LocationView: MKMarkerAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            if let _ = newValue as? Station {
					self.displayPriority = .defaultHigh
            }
        }
    }
}
