//
//  FlightSchedularLocationService.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
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
	
	func getAirportDetailForScheduleProcessing(origin:String,
															 destination:String,
															 dateFrom:String,
															 direct: Bool,
															 success: @escaping(ScheduleRequestParameter?)->Void,
															 failure: @escaping (FSServiceError?) -> Void)
	
	func getAirportDetailForScheduleProcessing(_ origin: String,
															 _ destination: String,
															 _ dateFrom: String,
															 _ direct: Bool)-> Observable<ScheduleRequestParameter>
	
	func getMapAnnotations(elements: [FlightElement],viewModel: FlightSchedularViewModelImp)-> [(arrival: MKAnnotation, departure: MKAnnotation)]
	func getMKPolyline(annotations :  [(arrival: MKAnnotation, departure: MKAnnotation)])-> MKPolyline
}


class FlightSchedularLocationService:FlightSchedularLocationServiceProtocol {
	
	var storage: FlightScheduleStorageService?
	var localIATA: Iata?
	var opsQueue: OperationQueue
	
	var localAirportData : [IATA]{
		return  localIATA?.map{ $0.value } ?? []
	}
	
	init(_ fLStorage: FlightScheduleStorageService) {
		opsQueue = OperationQueue()
		storage = fLStorage
		localIATA = storage?.localAITA
	}
	
	func getAirportDetailForScheduleProcessing(origin: String,
															 destination: String,
															 dateFrom:String ,
															 direct: Bool,
															 success: @escaping (ScheduleRequestParameter?) -> Void,
															 failure: @escaping (FSServiceError?) -> Void) {
		
		if origin.isEmpty { return failure(.OriginErr) }
		if destination.isEmpty { return failure(.DestinationErr) }
      
		let prepareScheduleOperation = BlockOperation {
			
			guard let originIATA = self.getAirportDetail(with: origin) else { return failure(.InvalidOriAirport) }
			guard let destinationIATA = self.getAirportDetail(with: destination) else { return failure(.InvalidDesAirport) }
			
			var schedule : ScheduleRequestParameter!
			schedule = ScheduleRequestParameter(journey: (origin: originIATA.iata, destination: destinationIATA.iata),
															fromDateTime: dateFrom, directFlights: direct, limit: "100", offset: "0")
			guard let _ = schedule else { return failure(.InvalideSchedule) }
			success(schedule)
		}
		opsQueue.addOperation(prepareScheduleOperation)
		
	}
	
	func getAirportDetailForScheduleProcessing(_ origin: String,
															 _ destination: String,
															 _ dateFrom: String,
															 _ direct: Bool) -> Observable<ScheduleRequestParameter> {
		
		return Observable<ScheduleRequestParameter>.create({ (observer) -> Disposable in
			 if origin.isEmpty {  observer.onError(APIError.readableError(.OriginErr)) }
			 if destination.isEmpty { observer.onError(APIError.readableError(.DestinationErr)) }
			
			guard let originIATA = self.getAirportDetail(with: origin) else {
			return Disposables.create {
					observer.onError(APIError.readableError(.InvalidOriAirport))
				}
			}
			guard let destinationIATA = self.getAirportDetail(with: destination) else { return Disposables.create {
				observer.onError(APIError.readableError(.InvalidDesAirport))
			} }

		var schedule : ScheduleRequestParameter!
		schedule = ScheduleRequestParameter(journey: (origin: originIATA.iata, destination: destinationIATA.iata),
														fromDateTime: dateFrom, directFlights: direct, limit: "100", offset: "0")
			guard let _ = schedule else { return Disposables.create {
				observer.onError(APIError.readableError(.InvalideSchedule))
				} }
		
			observer.onNext(schedule)
			observer.onCompleted()
		  return Disposables.create()
		})
	}

	func getAirportDetail(with airportName: String) ->IATA? {
		
		let localAirport = localIATA?.filter{ args in
			 airportName.clean.contains( args.value.name.clean)
		}.first
		let airport = localAirport?.value
		return airport
	}
	
	func getAirportDetail(code airportCode: String) ->IATA?{
		let localAirport = localIATA?.filter{ args in airportCode.clean.contains( args.key.clean) }.first
		let airport = localAirport?.value
		return airport
	}
	
	func getIATA(code value: String,airport:@escaping([IATA])->Void){
		 let data = 	localAirportData.filter{ args in args.name.clean.contains(value.clean)  || args.country.clean.contains(value.clean) }
		 airport(data)
	}
	
	func getMapAnnotations(elements: [FlightElement],viewModel: FlightSchedularViewModelImp) -> [(arrival: MKAnnotation, departure: MKAnnotation)] {
		var annotations : [(arrival:MKAnnotation,departure:MKAnnotation)] = []
		for item in elements{
			let flightModule = viewModel.getFlightModule(element: item)
			
			guard let arriveAnotation = (flightModule?.arrivalIATA.getAnnotation) else { continue }
			//arriveAnotation.title = flightModule?.arrivalAirport
			//arriveAnotation.subtitle = flightModule?.arrivalTime
			
			guard let destinationAnotation = (flightModule?.departtureIATA.getAnnotation) else { continue }
			//destinationAnotation.title = flightModule?.departAirport
			//destinationAnotation.subtitle = flightModule?.departTime
			annotations.append((arrival:arriveAnotation,departure:destinationAnotation))
		}
		 return annotations
	}
	
	
	func getMKPolyline(annotations :  [(arrival: MKAnnotation, departure: MKAnnotation)])-> MKPolyline{
		var points = [CLLocationCoordinate2D]()
		for annotation in annotations {
			points.append(annotation.departure.coordinate)
		   points.append(annotation.arrival.coordinate)
		}
		
		let polyline = MKPolyline(coordinates: &points, count: points.count)
      return polyline
				 
	}
	
	
	
}

