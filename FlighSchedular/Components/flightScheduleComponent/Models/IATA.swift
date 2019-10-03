//
//  IATA.swift
//  FlightSchedule
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
struct IATA: Codable {
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

typealias Iata = [String: IATA]
extension IATA {
	var getIata : String{
		return self.iata
	}
}
