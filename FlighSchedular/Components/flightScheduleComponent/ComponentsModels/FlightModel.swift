//
//  FlightModel.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 03/10/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
class FlightModel: NSObject {
	
	var aAirCode : String
	var dAirCode : String
	
	var arrivalIATA : IATA
	var departtureIATA : IATA
	
	var flightNumber : Int

	var arrivalTime : String
	var departTime : String

	var arrivalTerminal : String
	var departTerminal : String

	var arrivalAirport:String
	var departAirport:String
	var airplane: String
	
	
	// override init() {}
	
	
	
	init(flight : FlightElement,aIATA:IATA,dAITA: IATA) {
		arrivalIATA = aIATA
		departtureIATA = dAITA
		flightNumber = flight.marketingCarrier?.flightNumber ?? 0
		aAirCode = flight.arrival?.airportCode ?? ""
		dAirCode = flight.departure?.airportCode ?? ""
		arrivalTime = (flight.arrival?.scheduledTimeLocal?.dateTime ?? "").readableDate
		departTime = (flight.departure?.scheduledTimeLocal?.dateTime ?? "").readableDate
		arrivalTerminal = "Terminal : " + (flight.arrival?.terminal?.descriptionValue ?? "")
		departTerminal =  "Terminal : " + (flight.departure?.terminal?.descriptionValue ?? "")
		arrivalAirport = aIATA.name
		departAirport = dAITA.name
		airplane = "Lufthansa  - \(flight.marketingCarrier?.airlineID ?? "") -  \(flight.equipment?.descriptionValue ?? "")"
	}
	
}
