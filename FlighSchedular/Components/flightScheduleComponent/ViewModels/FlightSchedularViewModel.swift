//
//  FlightSchedularViewModel.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import MapKit
import RxSwift
import RxCocoa

protocol FlightSchedularViewModel: class {
	var  scheduleFlightElement :[FlightElement]{get}
	var  activeFlightModule : FlightModel?{get set}
	var  selectedSchedule : Schedule?{get set}
	var  scheduleError : APIError?{ get set }
	var  storageService : FlightScheduleStorageService { get }
	var  flightScheduleResource : ScheduleResource?{ set get }
	var  flightSchedules : [Schedule]{ get }
	var  apiService : FlightScheduleAPIServiceImpl { get }
	var  tripRequestParameter : BehaviorRelay<ScheduleRequestParameter>? { get set  }
	var  coordinatorDelegate : JourneyMapViewCoordinatorDelegate?{ get set }
	var  searchResults: BehaviorRelay<[IATA]>?{ get set }
	var  searchCompleter : PublishSubject<String>?{get set}
	var  disposeBag : DisposeBag?{get set }
	var  locationService : FlightSchedularLocationService{ get }
	func openSearchAirportView()
	func getFlightSchedules(from: String,to: String,dateFrom: String,directFlight: Bool )
	var  placesCoordinatorDelegate : SearchForPlacesCoordinatorDelegate?{get set}
	var  scheduleCoordinatorDelegate :   FlightSchedulesCoordinatorProtocol? {get set}
	func scheduleAtIndex(_ index : IndexPath) -> Schedule
	func getFlightModule(element : FlightElement)->FlightModel?
	func getFlightModule(at index : IndexPath)->FlightModel?
	func scheduleFlightElement(at index : IndexPath) -> FlightElement
	func annotationsForMap()-> [(arrival: MKAnnotation, departure: MKAnnotation)]
	func getpolyLine()->MKPolyline
	func mkAnnotations() -> [MKAnnotation]
}
