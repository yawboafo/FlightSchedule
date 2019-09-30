//
//  FlightSchedularViewModel.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
protocol FlightSchedularViewModel: class {
	var coordinatorDelegate : JourneyMapViewCoordinatorDelegate?{ get set }
  
	func searchforNearByAirports()
	
	
}
