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
	var coordinatorDelegate : JourneyMapViewCoordinatorDelegate?{ get set }
	var searchResults: BehaviorRelay<[MKLocalSearchCompletion]>? { get set }  //= BehaviorRelay(value: [])
	var searchCompleter : MKLocalSearchCompleter?{get set}
	var  disposeBag : DisposeBag? {get set }
	func searchforNearByAirports()
	
	
}
