//
//  FlightScheduleViewModelTests.swift
//  FlighSchedularTests
//
//  Created by Engineer 144 on 05/10/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import XCTest
import RxBlocking
import RxSwift
import RxCocoa
import RxTest
@testable import FlighSchedular

class FlightScheduleViewModelTests: XCTestCase {

	
	var viewModel : FlightSchedularViewModelImp!
    override func setUp() {
		viewModel = FlightSchedularViewModelImp()
		viewModel.placesCoordinatorDelegate = self
		viewModel.coordinatorDelegate = self
		viewModel.scheduleCoordinatorDelegate = self 
    }

    override func tearDown() {
        viewModel = nil
    }

	func testInitiationVariables(){
		XCTAssertNotNil(viewModel.coordinatorDelegate)
		XCTAssertNotNil(viewModel.placesCoordinatorDelegate)
		XCTAssertNotNil(viewModel.scheduleCoordinatorDelegate)
		XCTAssertNotNil(viewModel.locationService)
		XCTAssertNotNil(viewModel.apiService)
		XCTAssertNotNil(viewModel.disposeBag)
	}

    

}



extension FlightScheduleViewModelTests : SearchForPlacesCoordinatorDelegate,JourneyMapViewCoordinatorDelegate,FlightSchedulesCoordinatorProtocol{
	func presentMapView() {
		XCTAssert(true)
	}
	
	func showDetail(model: FlightSchedularViewModelImp) {
		
	}
	
	func showDetail(model: FlightSchedularViewModelImp, data: BehaviorRelay<[FlightElement]>) {
		
	}
	
	func showError(error: APIError) {
		
	}
	
	func showSchedules(schedules: ScheduleResource) {
		
	}
	
	func showSipnner() {
		
	}
	
	func presentView() {
		
	}
	
	
}
