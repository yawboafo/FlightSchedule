//
//  ScheduleAPIService.swift
//  AirLineSchedular
//
//  Created by Engineer 144 on 28/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
class FlightScheduleAPIService {
	var request : APIRequest!
	var requestor : APIRequestExecuter!
	
	func tokenRequest(_ completionHandler: @escaping(Result<TokenResponse, APIError>)->Void) {
		
		let urlRequest  = try? buildTokenAPIRequest()
		guard let _urlRequest = urlRequest else { return  }
		let request = APIRequestExecuter(_urlRequest)
			return request.execute { response in
			        completionHandler(response)
		}
		
	}
	func flightScheduleRequest(_ token: Token,
										_ parameter: ScheduleRequestParameter,
										_ completionHandler: @escaping(Result<ScheduleAPIResponse, APIError>)->Void){
		
		let urlRequest  = try? buildScheduleAPIRequest(token: token,parameter: parameter)
			guard let _urlRequest = urlRequest else { return  }
			let request = APIRequestExecuter(_urlRequest)
				return request.execute { response in
								completionHandler(response)
			}
		
	}
	
	func tokenRequest(_ request: URLRequest?,
							_ completionHandler: @escaping(Result<TokenResponse, APIError>)->Void) {
		
		guard let _urlRequest = request else { return  }
		let request = APIRequestExecuter(_urlRequest)
			return request.execute { response in
			        completionHandler(response)
		}
		
	}
	func flightScheduleRequest(_ request : URLRequest?,
										_ completionHandler: @escaping(Result<ScheduleAPIResponse, APIError>)->Void){
		
			guard let _urlRequest = request else { return  }
			let request = APIRequestExecuter(_urlRequest)
				return request.execute { response in
								completionHandler(response)
			}
		
	}
	
}


extension FlightScheduleAPIService {
	
	func buildScheduleAPIRequest(timeOutinterval: TimeInterval = 10.0,
										   httpMethod: HTTPMethods = .get,
										   token: Token?,
											parameter: ScheduleRequestParameter?) throws -> URLRequest {
		
		guard let parameter = parameter else { throw APIError.invalidBody }
		if parameter.journey.destination.count == 0 { throw APIError.invalidBody }
		if parameter.journey.origin.count == 0 { throw APIError.invalidBody }

		guard let urlString = APIEndPoint.buildStringURL(urlPaths: [.operations,.schedules],
																		 otherPaths: [parameter.journeyStringRepresentation,
																						  parameter.fromDateTime]) else { throw APIError.invalidEndpoint }
			                                     
		guard let url = URL(string: urlString) else { throw APIError.invalidURL }
		guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
			throw APIError.invalidURL
		}
		
		urlComponents.queryItems = [URLQueryItem(name: Keys.directFlights.rawValue,value: parameter.directFlights.description),
																URLQueryItem(name: Keys.limit.rawValue,value: parameter.limit),
																URLQueryItem(name: Keys.offset.rawValue,value: parameter.offset)]
		
		guard let componentURL = urlComponents.url else { throw APIError.invalidURLComponent }
		var request = URLRequest(url: componentURL,
                               cachePolicy: .useProtocolCachePolicy,
                               timeoutInterval: timeOutinterval)
		
	   request.httpMethod = httpMethod.rawValue
		guard let _token = token else { throw APIError.invalidToken }
		guard let accessToken = _token?.accessToken else { throw APIError.invalidToken }
		if _token.Expired { throw APIError.tokenExpired }
	   var header : [String:String] = APIRequest.defaultHeader
		header.update(other: [Keys.accessToken.rawValue:"Bearer \(accessToken)"])
		request.allHTTPHeaderFields = header
	   if httpMethod != HTTPMethods.get { throw APIError.invalidURL }

    return request

	}
	
	func buildTokenAPIRequest(timeOutinterval: TimeInterval = 10.0,
									  httpMethod: HTTPMethods = .post,
									  httpHeader: [String:String] = [Keys.contentType.rawValue:Values.urlencoded.rawValue]) throws -> URLRequest {
		
		if httpHeader.isEmpty { throw APIError.invalidURL}
		guard let urlString = APIEndPoint.buildStringURL(urlPaths: [.oauth,.token],
																		 otherPaths: []) else { throw APIError.invalidEndpoint }
		
		guard let url = URL(string: urlString) else { throw APIError.invalidURL }
		var request = URLRequest(url: url,
                               cachePolicy: .useProtocolCachePolicy,
                               timeoutInterval: timeOutinterval)
		
		request.httpMethod = httpMethod.rawValue
      request.allHTTPHeaderFields = httpHeader
		request.encodeParameters(parameters: [Keys.client_id.rawValue: Values.clientIDValue.rawValue,
														  Keys.client_secret.rawValue: Values.clientSecretValue.rawValue,
														  Keys.grant_type.rawValue:Values.clientCredentials.rawValue])
		
		if httpMethod != HTTPMethods.post { throw APIError.invalidURL }
      return request
		
	}
}
