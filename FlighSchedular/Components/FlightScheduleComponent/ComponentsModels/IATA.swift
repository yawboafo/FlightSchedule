//
//  IATA.swift
//  FlightSchedule
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import MapKit

public typealias Iata = [String: IATA]

public struct IATA: Codable {
    let name, city, country, iata: String
    let icao, latitude, longitude, altitude: String
    let timezone: String
    let dst: Dst
}

enum Dst: String, Codable {
    case a = "A"
    case e = "E"
    case empty = ""
    case n = "N"
    case o = "O"
    case s = "S"
    case u = "U"
    case z = "Z"
}


extension IATA {
	var getIata : String{
		return self.iata
	}
	
	var getCoordinates : CLLocationCoordinate2D{
		return CLLocationCoordinate2D(latitude: Double(latitude) ?? 0.00, longitude: Double(longitude) ?? 0.00)
	}
	
	var getAnnotation : Station{
		
		return Station(latitude: Double(latitude) ?? 0.00, longitude: Double(longitude) ?? 0.00, title: name,subtitle: country)
	}
}


