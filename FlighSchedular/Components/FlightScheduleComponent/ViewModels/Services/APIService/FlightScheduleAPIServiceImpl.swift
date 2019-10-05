//
//  ScheduleAPIService.swift
//  AirLineSchedular
//
//  Created by Engineer 144 on 28/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import RxSwift
class FlightScheduleAPIServiceImpl {
	
	func tokenRequest(_ completionHandler: @escaping(Result<TokenResponse, APIError>)->Void) {
		
		let urlRequest  = try? buildTokenAPIRequest()
		guard let _urlRequest = urlRequest else { return completionHandler(.failure(.invalidURL))  }
		let request = APIRequestExecuter(_urlRequest)
			return request.execute { response in
			        completionHandler(response)
		}
		
	}
	
	func flightScheduleRequest(_ token: Token,
										_ parameter: ScheduleRequestParameter,
										_ completionHandler: @escaping(Result<ScheduleAPIResponse, APIError>)->Void){
		
		let urlRequest  = try? buildScheduleAPIRequest(token: token,parameter: parameter)
		guard let _urlRequest = urlRequest else { return completionHandler(.failure(.tokenExpired))  }
			let request = APIRequestExecuter(_urlRequest)
				return request.execute { response in
								completionHandler(response)
			}
		
	}
	
	func tokenRequest(_ request: URLRequest?,
							_ completionHandler: @escaping(Result<TokenResponse, APIError>)->Void) {
		
		guard let _urlRequest = request else { return completionHandler(.failure(.tokenExpired)) }
		let request = APIRequestExecuter(_urlRequest)
			return request.execute { response in
			        completionHandler(response)
		}
		
	}
	
	func flightScheduleRequest(_ request : URLRequest?,
										_ completionHandler: @escaping(Result<ScheduleAPIResponse, APIError>)->Void){
		
		guard let _urlRequest = request else { return completionHandler(.failure(.invalidURL)) }
			let request = APIRequestExecuter(_urlRequest)
				return request.execute { response in
								completionHandler(response)
			}

	}
	
}


extension FlightScheduleAPIServiceImpl {
	
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
		//if _token.Expired { throw APIError.tokenExpired }
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

extension FlightScheduleAPIServiceImpl:FlightScheduleAPIService {
	var FLstorage: FlightScheduleStorageService {
		    return FlightScheduleStorageService()
	}
	
	func flightScheduleRequest(_ parameter: ScheduleRequestParameter,
										_ successful:@escaping(ScheduleResource?) -> Void,
										_ failed: @escaping(APIError) -> Void) {
		let request = try? buildScheduleAPIRequest(token: self.FLstorage.token, parameter: parameter)
		flightScheduleRequest(request) { (result) in
			switch result{

				case .success(let success):
					successful(success.scheduleResource)
				case .failure(let error):
				   failed(error)
			}
		}
		
	}
	
	func tokenRequest()->Observable<Token>{
		return Observable<Token>.create { [weak self](observer) -> Disposable in
			guard let self = self else { return Disposables.create() }
			self.tokenRequest { (result) in
				switch result {
					case .success(let data):
						var token = data
						let expiresIn = token.expiresIn
						token.expiredDate = Date().addingTimeInterval(TimeInterval(expiresIn)).description
						print()
						self.FLstorage.token = token
						observer.onNext(data)
						observer.onCompleted()
					break
					case .failure(let error):
						observer.onError(error)
					break
				}
			}
			return Disposables.create()
		}
	}
	
	func flightScheduleRequest(token:Token, _ parameter: ScheduleRequestParameter)->Observable<ScheduleResource>{
		return Observable<ScheduleResource>.create { [weak self](observer) -> Disposable in
			guard let self = self else { return Disposables.create{ observer.onError(APIError.invalidBody)} }
			self.flightScheduleRequest(token, parameter) { (result) in
				switch result{
					case .success(let data):
				   guard let resource = data.scheduleResource else { return observer.onError(APIError.emptyData) }
				   observer.onNext(resource)
					observer.onCompleted()
					case .failure(let error):
				   observer.onError(error)
				}
			}
			
			return Disposables.create()
		}
	}
}
