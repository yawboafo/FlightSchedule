//
//  APIError.swift
//  AirLineSchedular
//
//  Created by Engineer 144 on 28/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case invalidBody
	 case invalidToken
	 case tokenExpired
    case invalidEndpoint
    case invalidURL
	 case invalidURLComponent
    case emptyData
    case invalidJSON
    case invalidResponse
    case statusCode(Int)
	 case mainError(Error)
	 case decoderError
	 case failDecode(Data,Error)
}
