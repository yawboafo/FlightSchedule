//
//  FlightScheduleAPIService.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 01/10/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import RxSwift

protocol FlightScheduleAPIService: class {
	var FLstorage:FlightScheduleStorageService { get }
	
	func tokenRequest(_ completionHandler: @escaping(Result<TokenResponse, APIError>)->Void)
	
	func flightScheduleRequest(_ parameter: ScheduleRequestParameter,
										_ successful: @escaping(ScheduleResource?) -> Void,
										_ failed: @escaping(APIError) -> Void)
	
	func flightScheduleRequest(_ token: Token,
										_ parameter: ScheduleRequestParameter,
										_ completionHandler:@escaping(Result<ScheduleAPIResponse, APIError>)->Void)
	
	func tokenRequest(_ request: URLRequest?,
							_ completionHandler: @escaping(Result<TokenResponse, APIError>)->Void)
	
	func flightScheduleRequest(_ request : URLRequest?,
										_ completionHandler: @escaping(Result<ScheduleAPIResponse, APIError>)->Void)
	
	func tokenRequest()->Observable<Token>
	
	func buildScheduleAPIRequest(timeOutinterval: TimeInterval,httpMethod: HTTPMethods,token: Token?,parameter: ScheduleRequestParameter?) throws -> URLRequest
	
	func buildTokenAPIRequest(timeOutinterval: TimeInterval,httpMethod: HTTPMethods,httpHeader: [String:String]) throws -> URLRequest
}
