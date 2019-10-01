//
//  APIRequest.swift
//  AirLineSchedular
//
//  Created by Engineer 144 on 28/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import Combine

class APIRequest {
	
static var defaultHeader : [String:String] = {
		return [Keys.contentType.rawValue : Values.contentTypeValue.rawValue,
						Keys.clientID.rawValue : Values.clientIDValue.rawValue,
						Keys.clientSecret.rawValue : Values.clientSecretValue.rawValue,
						Keys.accept.rawValue : Values.contentTypeValue.rawValue]
	}()
	
	
	func validate(_ data: Data, _ response: URLResponse) throws -> Data {
			guard let httpResponse = response as? HTTPURLResponse else {
					throw APIError.invalidResponse
			}
			guard (200..<300).contains(httpResponse.statusCode) else {
					throw APIError.statusCode(httpResponse.statusCode)
			}
			return data
	}

}


