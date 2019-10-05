//
//  FlightSchedularViewModelImp.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import MapKit
import RxSwift
import RxCocoa

class FlightSchedularViewModelImp : FlightSchedularViewModel{
	
	var scheduleCoordinatorDelegate: FlightSchedulesCoordinatorProtocol?
	var coordinatorDelegate: JourneyMapViewCoordinatorDelegate?
	var placesCoordinatorDelegate : SearchForPlacesCoordinatorDelegate?
	
	var storageService: FlightScheduleStorageService
	var apiService: FlightScheduleAPIServiceImpl
	var locationService: FlightSchedularLocationService
	var searchCompleter: PublishSubject<String>?
	
	var disposeBag: DisposeBag?
	var searchResults: BehaviorRelay<[IATA]>?
	var tripRequestParameter: BehaviorRelay<ScheduleRequestParameter>?
	
	init(){
		disposeBag = DisposeBag()
		searchResults = BehaviorRelay(value: [])
		searchCompleter =  PublishSubject<String>()
		apiService = FlightScheduleAPIServiceImpl()
		storageService = FlightScheduleStorageService()
		locationService = FlightSchedularLocationService(storageService)
		scheduleError = .emptyData
		instantiate()
	}
	
	var scheduleError : APIError?{
		willSet{
			DispatchQueue.main.async {
				self.placesCoordinatorDelegate?.showError(error: newValue ?? APIError.emptyData)
			}
		}
	}
	
	private func instantiate(){
		guard let searchCompleter = searchCompleter else { return  }
		searchCompleter.subscribe(onNext: { [weak self] (value) in
			print(value)
			self?.getAirports(value: value )
		}).disposed(by: disposeBag!)
		
		
	}
	
	var flightScheduleResource: ScheduleResource?{
		willSet{
			DispatchQueue.main.async {
				guard let resource = newValue else { return  }
				self.placesCoordinatorDelegate?.showSchedules(schedules: resource)
			}
		}
	 }
	
	var flightSchedules: [Schedule]{
		return flightScheduleResource?.schedule ?? []
	}
	
	var selectedSchedule : Schedule?
	
	var scheduleFlightElement : [FlightElement]{
		return selectedSchedule?.flightElements ?? []
	}
	
	var activeFlightModule : FlightModel?
	
	var flightsElementRelay: BehaviorRelay<[FlightElement]> {
		let relay = BehaviorRelay<[FlightElement]>(value: scheduleFlightElement)
	   return relay
	}

	func openSearchAirportView() {
		self.coordinatorDelegate?.presentView()
	}
	
	func openMapView(){
		self.scheduleCoordinatorDelegate?.presentMapView()
	}
	
	func setActiveSchedule(schedule : Schedule){
		self.selectedSchedule = schedule
		let elementRelay : BehaviorRelay<[FlightElement]> = BehaviorRelay(value: schedule.flightElements)
		self.scheduleCoordinatorDelegate?.showDetail(model: self, data: elementRelay)
	}
	
	func scheduleAtIndex(_ index : IndexPath) -> Schedule{
		return flightSchedules[index.item]
	}
	
	func scheduleFlightElement(at index : IndexPath) -> FlightElement{
		return scheduleFlightElement[index.item]
	}
	
	func getFlightModule(element : FlightElement)->FlightModel? {
		guard	let arrivalDetail = airport(code: element.arrival?.airportCode ?? "") else { return nil }
		guard let departDetail = airport(code:  element.departure?.airportCode ?? "") else { return nil }
		let model = FlightModel(flight: element, aIATA: arrivalDetail, dAITA: departDetail)
		activeFlightModule = model
		return model
	}
	
	func getFlightModule(at index : IndexPath)->FlightModel? {
   let element = scheduleFlightElement[index.item]
		
		guard	let arrivalDetail = airport(code: element.arrival?.airportCode ?? "") else { return nil }
		guard let departDetail = airport(code:  element.departure?.airportCode ?? "") else { return nil }
				
		
	let model = FlightModel(flight: element, aIATA: arrivalDetail, dAITA: departDetail)
		activeFlightModule = model

		return model
	}
	
	func getFlightSchedules(from: String,
									to: String,
									dateFrom: String = ALS.scheduleDefaultDate,
									directFlight: Bool = false) {
		
		placesCoordinatorDelegate?.showSipnner()
		locationService.getAirportDetailForScheduleProcessing(origin: from,
																				destination: to,
																				dateFrom: dateFrom,
																				direct: directFlight,
																				success: { [weak self] params in
													
		     self?.getFlightSchedule(schedule: params!)
																	
		}) { [weak self](error) in
			   self?.scheduleError = APIError.readableError(error!)
		}
		
	}
	
	func getFlightSchedule(schedule:ScheduleRequestParameter){
		
	 if storageService.token.Expired{
		
		self.apiService.tokenRequest()
			.flatMap {  result in
				self.apiService.flightScheduleRequest(token:result, schedule) 
			}
			.subscribe(onNext: {[weak self] result  in
				self?.flightScheduleResource = result
			},
			onError: {[weak self]  error in
				self?.scheduleError = error as? APIError
			})
			.disposed(by: disposeBag!)
			
		}else{
			apiService.flightScheduleRequest(schedule, { [weak self] (result) in
				self?.flightScheduleResource = result
			}) { (error) in
				self.scheduleError = error
			}
		}
		
	}
	
	func airportName(code: String) -> String {
		   return locationService.getAirportDetail(code: code)?.name ?? code
	}
	
	func airport(code: String) -> IATA? {
		   return locationService.getAirportDetail(code: code)
	}
	
	func getAirports(value:String){
		locationService.getIATA(code: value) {  [weak self](values) in
			self?.searchResults?.accept(values)
		}
	}
	
	func annotationsForMap()-> [(arrival: MKAnnotation, departure: MKAnnotation)]{
		return locationService.getMapAnnotations(elements: scheduleFlightElement, viewModel: self)
	}
	
	func getpolyLine()->MKPolyline{
		return locationService.getMKPolyline(annotations: annotationsForMap())
	}
	//(latitude: 50.901401519800004, longitude: 4.48443984985)
	func mkAnnotations() -> [MKAnnotation]{
		/**return annotationsForMap().compactMap{ args in
			let arrayofAnnotation : [MKAnnotation]  = [args.departure,args.arrival]
			//print(arrayofAnnotation,args.departure.coordinate,args.arrival.coordinate)
			return arrayofAnnotation as?  MKAnnotation
		}**/
		var annotations = [MKAnnotation]()
		annotationsForMap().forEach{ args in
			annotations.append(contentsOf: [args.arrival,args.departure])
			
		}

		
		
		
	/**	let c = Station(latitude:  50.901401519800004,
									  longitude: 4.48443984985, title: "Taifa",subtitle: "Toho")
	 
		return [c]**/
		return annotations
	}
	
}



