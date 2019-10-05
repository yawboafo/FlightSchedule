//
//  FlightScheduleAPIServiceTests.swift
//  FlighSchedularTests
//
//  Created by Engineer 144 on 05/10/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import XCTest

@testable import FlighSchedular

class FlightScheduleAPIServiceTests: XCTestCase {

	var service : FlightScheduleAPIServiceImpl!
    override func setUp() {
       service = FlightScheduleAPIServiceImpl()
    }

    override func tearDown() {
       service = nil
    }

	func testURLRequestBuilders(){
		
		XCTAssertNoThrow(try service.buildTokenAPIRequest())
		let schedule = ScheduleRequestParameter(journey: (origin: "STV", destination: "FRA"),
															 fromDateTime: "2019-10-5",
															 directFlights: false,
															 limit: "100",
															 offset: "0")
		XCTAssertThrowsError(try service.buildScheduleAPIRequest(timeOutinterval: 10.0, httpMethod: .get, token: nil, parameter: schedule))
    
		
	}

}
