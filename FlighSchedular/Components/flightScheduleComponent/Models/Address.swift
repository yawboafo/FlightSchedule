//
//  Address.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import MapKit

struct Address {
	var address : String?
	var coordinates : Coordinate?
	
	init(address:String,coordinates : Coordinate) {
		self.address = address
		self.coordinates = coordinates
	}
	init(title:String ,location: CLLocationCoordinate2D) {
		self.address = title
		self.coordinates = Coordinate(latitude: location.latitude, longitude: location.longitude)
	}
}
struct Coordinate: Codable {
	let latitude, longitude: Double
}
