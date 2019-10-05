//
//  FlightSchedularLocationServiceProtocol.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 05/10/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import MapKit
import RxSwift

public enum FSServiceError : String {
	case OriginErr =      "Origin Airport is Required"
	case DestinationErr = "Destination Airport is Required"
	case InvalidOriAirport = "Failed to get AirportCode for Origin Airport"
	case InvalidDesAirport = "Failed to get AirportCode forDestination Airport"
	case InvalideSchedule = "Invalid Schedule Detail"
}


protocol FlightSchedularLocationServiceProtocol: class {
	var localIATA : Iata? {get set}
	var opsQueue : OperationQueue{ get }
	var storage : FlightScheduleStorageService?{get set}
		
   func getAirportDetail(with airportName: String) ->IATA?
	
   func getAirportDetail(code airportCode: String) ->IATA?
	
	
	func getAirportDetailForScheduleProcessing(_ origin: String,
															 _ destination: String,
															 _ dateFrom: String,
															 _ direct: Bool)-> Observable<ScheduleRequestParameter>
	
	func getMapAnnotations(elements: [FlightElement],viewModel: FlightSchedularViewModelImp)-> [(arrival: MKAnnotation, departure: MKAnnotation)]
	func getMKPolyline(annotations :  [(arrival: MKAnnotation, departure: MKAnnotation)])-> MKPolyline
}

