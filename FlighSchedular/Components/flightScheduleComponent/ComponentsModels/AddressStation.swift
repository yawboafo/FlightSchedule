//
//  Address.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import MapKit

struct AddressStation {
	var address : String?
	var coordinates : CLLocationCoordinate2D?
	
	init(address:String,coordinates : Coordinate) {
		self.address = address
		self.coordinates = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
	}
	
	
}
struct Coordinate: Codable {
	let latitude, longitude: Double
}
