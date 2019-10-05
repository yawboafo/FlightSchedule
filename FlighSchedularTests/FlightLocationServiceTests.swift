//
//  FlightLocationServiceTests.swift
//  FlighSchedularTests
//
//  Created by Engineer 144 on 05/10/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import XCTest

@testable import FlighSchedular
class FlightLocationServiceTests: XCTestCase {
 
	var locationService : FlightSchedularLocationService!
	var storageService : FlightScheduleStorageService!
	
    override func setUp() {
		storageService = FlightScheduleStorageService()
		locationService = FlightSchedularLocationService(storageService)
     }

    override func tearDown() {
       storageService = nil
		 locationService = nil
    }

	func testInitialVariables(){
		XCTAssertNotNil(storageService)
		guard let localAirports = locationService.localIATA else {
			XCTFail("LocalIATA cannot be nil ")
			return
		 }
		XCTAssert(localAirports.count > 0)
	}
	
	func testAirportDetailScheduleProssesor(){

		let expect = expectation(description: "schedule detail processor")
		locationService.getAirportDetailForScheduleProcessing(origin: "Manhattan Regional Airport",
																				destination: "Surat Airport",
																				dateFrom: "2019-10-05",
																				direct: true,
																				success: { result in
																				XCTAssertNotNil(result)
																				expect.fulfill()
																					
		}) { (error) in
			XCTFail(error.debugDescription)
         expect.fulfill()
		}
		
		wait(for: [expect], timeout: 3.0)
	}
	
	func testObservableAirportDetailScheduleProssesor(){

		//let observer =  locationService.getAirportDetailForScheduleProcessing("ZRH", "FRA", "2019-10-05", true)
		//XCTAssertNoThrow(try observer.toBlocking().single())
	}
	
	func testGetAirportInfo(){
		XCTAssertNotNil(locationService.getAirportDetail(code: "STV"))
		XCTAssertNotNil(locationService.getAirportDetail(with: "Dubrovnik Airport"))
		
		locationService.getIATA(code: "STV") { (airports) in
			XCTAssert(airports.count > 0)
		}
	}

}
