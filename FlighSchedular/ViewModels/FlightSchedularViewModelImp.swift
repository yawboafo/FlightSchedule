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
	var storageService: FlightScheduleStorageService
	var apiService: FlightScheduleAPIService
	var locationService: FlightSchedularLocationService
	var searchCompleter: MKLocalSearchCompleter?
	var disposeBag: DisposeBag?
	var searchResults: BehaviorRelay<[MKLocalSearchCompletion]>?
	var coordinatorDelegate: JourneyMapViewCoordinatorDelegate?
	var tripRequestParameter: BehaviorRelay<ScheduleRequestParameter>?
	func openSearchAirportView() {
		self.coordinatorDelegate?.presentView()
	}
	
	init() {
		disposeBag = DisposeBag()
		searchResults = BehaviorRelay(value: [])  //?.accept([])
		searchCompleter =  MKLocalSearchCompleter()
		locationService = FlightSchedularLocationService()
		apiService = FlightScheduleAPIService()
		storageService = FlightScheduleStorageService()
		instantiate()
	}
	private func instantiate(){
		let category : [MKPointOfInterestCategory] = [.airport]
		guard let searchCompleter = searchCompleter else { return  }
		searchCompleter.pointOfInterestFilter = MKPointOfInterestFilter(including: category)
		searchCompleter.rx.didUpdateResults
							.subscribe(onNext: { [weak self] completer  in
								var value = completer.results
								if completer.results.isEmpty {
									value.removeAll()
									self?.searchResults?.accept(value)
								}else{
									self?.searchResults?.accept(value)
								}
							
							})
							.disposed(by: disposeBag!)
	}
	func getFlightSchedules(from: String,
									to: String,
									dateFrom: String = "2019-09-30") {
		
	
		locationService.getAirportDetailForScheduleProcessing(origin: from,destination: to,dateFrom: dateFrom,success: { [weak self] params in
			if (self?.storageService.token.Expired)! {
					self?.apiService.tokenRequest { [weak self ](result) in
						switch result {
							case .success(let data):
								self?.storageService.token = data
							break
							case .failure(_):
							break
						}
					}
				}else{
					let request = try? self?.apiService.buildScheduleAPIRequest(token: self?.storageService.token, parameter: params)
					self?.apiService.flightScheduleRequest(request) { (result) in
						
					}
				}
																						
																					
		}) { (error) in
			print(error.debugDescription)
		}
		
		
	
		
	}
	
	func getPlaceName(query:MKLocalSearchCompletion){
	   	locationService.search(with: query) { (add) in
			
		}
	}
	
	
}
//+5.60379884,-0.16843675
