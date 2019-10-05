//
//  ScheduleModel.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 02/10/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
class ScheduleModel: NSObject {
	
	var journeyTime : String?
	var totalTransits : String?
	
	
	init(schedule : Schedule) {
		super.init()
		
		journeyTime = schedule.totalJourney?.duration ?? ""
		totalTransits = "\(schedule.flightElements.count)"
		
		
	}
}

class FlightModel: NSObject {
	var aAirCode : String
	var dAirCode : String
	
	var flightNumber : Int

	var arrivalTime : String
	var departTime : String

	var arrivalTerminal : String
	var departTerminal : String

	var arrivalAirport:String
	var departAirport:String
	var airplane: String
	
	init(flight : FlightElement,aairport: String,dairport: String) {
		flightNumber = flight.marketingCarrier?.flightNumber ?? 0
		aAirCode = flight.arrival?.airportCode ?? ""
		dAirCode = flight.departure?.airportCode ?? ""
		arrivalTime = flight.arrival?.scheduledTimeLocal?.dateTime ?? ""
	   departTime = flight.departure?.scheduledTimeLocal?.dateTime ?? ""
		arrivalTerminal = "Terminal : " + (flight.arrival?.terminal?.descriptionValue ?? "")
		departTerminal =  "Terminal : " + (flight.departure?.terminal?.descriptionValue ?? "")
		arrivalAirport = aairport
		departAirport = dairport
		airplane = "Lufthansa  - \(flight.marketingCarrier?.airlineID ?? "") -  \(flight.equipment?.descriptionValue ?? "")"
	}
}
