//
//  Station.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import MapKit
class Station :NSObject, MKAnnotation{
	var title: String?
	var subtitle: String?
	var latitude: Double
	var longitude:Double
	
	var coordinate: CLLocationCoordinate2D {
		 return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
	}
	
	init(latitude: Double, longitude: Double,title:String,subtitle:String) {
		 self.latitude = latitude
		 self.longitude = longitude
		 self.title  = title
		 self.subtitle = subtitle
	}
	
	
}
