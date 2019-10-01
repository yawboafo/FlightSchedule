//
//  FlightSchedularLocationService.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import MapKit


enum FSServiceError : String {
	case OriginErr = "Origin is Required"
	case DestinationErr = "Destination is Required"
	case InvalidOriAirport = "Enter Valid Origin Airport"
	case InvalidDesAirport = "Enter Valid Destination Airport"
	case InvalideSchedule = "Invalid Schedule Detail"
}

protocol FlightSchedularLocationServiceProtocol:class {
	var opsQueue : OperationQueue{ get }
	func search(with searhItem : MKLocalSearchCompletion,completionHandler: @escaping(Address?)->Void)
   func getAirportDetail(with airportName: String) ->IATA?
	func getAirportDetailForScheduleProcessing(origin:String,
															 destination:String,
															 dateFrom:String,
															 success: @escaping(ScheduleRequestParameter?)->Void,
															 failure: @escaping (FSServiceError?) -> Void)
}



class FlightSchedularLocationService: FlightSchedularLocationServiceProtocol {
	var opsQueue: OperationQueue
	
	init() {
		opsQueue = OperationQueue()
	}
	
	func getAirportDetailForScheduleProcessing(origin: String,
															 destination: String,
															 dateFrom:String ,
															 success: @escaping (ScheduleRequestParameter?) -> Void,
															 failure: @escaping (FSServiceError?) -> Void) {
		
		if origin.isEmpty { return failure(.OriginErr) }
		if destination.isEmpty { return failure(.DestinationErr) }
      
		let prepareScheduleOperation = BlockOperation {
			
			guard let originIATA = self.getAirportDetail(with: origin) else { return failure(.InvalidOriAirport) }
			guard let destinationIATA = self.getAirportDetail(with: destination) else { return failure(.InvalidDesAirport) }
			
			var schedule : ScheduleRequestParameter!
			schedule = ScheduleRequestParameter(journey: (origin: originIATA.iata, destination: destinationIATA.iata),
															fromDateTime: dateFrom, directFlights: false, limit: "100", offset: "0")
			guard let _ = schedule else { return failure(.InvalideSchedule) }
			success(schedule)
		}
		opsQueue.addOperation(prepareScheduleOperation)
		
	}
	
	func getAirportDetail(with airportName: String) ->IATA? {
		let locals = try? cache.IATAlocal()
		let localAirport = locals?.filter{ args in args.value.name.clean.contains(airportName.clean) }.first
		let airport = localAirport?.value
		return airport
	}
	func search(with searhItem: MKLocalSearchCompletion,
					completionHandler: @escaping (Address?) -> Void) {
		let searchRequest = MKLocalSearch.Request(completion: searhItem)
		let search = MKLocalSearch(request: searchRequest)
		search.start { (response, error) in
			
			let coordinate = response?.mapItems[0].placemark.coordinate
			let title = response?.mapItems[0].placemark.title
			
  
			guard let position = coordinate else { return completionHandler(nil)}
			guard let addressName = title else { return completionHandler(nil)}
			let addresss = Address(title: addressName, location: position)
			completionHandler(addresss)
		
			
		}
	}
	
	
}
