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
	var searchCompleter: MKLocalSearchCompleter?
	var disposeBag: DisposeBag?
	var searchResults: BehaviorRelay<[MKLocalSearchCompletion]>?
	var coordinatorDelegate: JourneyMapViewCoordinatorDelegate?
	
	func searchforNearByAirports() {
		self.coordinatorDelegate?.beginSearch()
	}
	
	init() {
		disposeBag = DisposeBag()
		searchResults = BehaviorRelay(value: [])  //?.accept([])
		searchCompleter =  MKLocalSearchCompleter()
		instantiate()
	}
	
	private func instantiate(){
		let category : [MKPointOfInterestCategory] = [.airport]
		guard let searchCompleter = searchCompleter else { return  }
		searchCompleter.pointOfInterestFilter = MKPointOfInterestFilter(including: category)
		searchCompleter.rx.didUpdateResults
							.subscribe(onNext: { [weak self] completer  in
								
								if completer.results.isEmpty {
									self?.searchResults?.accept([])
								}else{
									self?.searchResults?.accept(completer.results)
								}
							
							})
							.disposed(by: disposeBag!)
	}
	
}
