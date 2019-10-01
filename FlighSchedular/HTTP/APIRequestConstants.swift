//
//  APIRequestConstants.swift
//  AirLineSchedular
//
//  Created by Engineer 144 on 28/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation

public enum Values : String {
	case contentTypeValue = "application/json"
	case clientIDValue = "3pd9x7unymrujgry49rqegzm"
	case clientSecretValue = "2769fas2Da"
	case accessTokenValue = "Bearer jmhqecnfdmds3nwbvzy8hj7tpq"
	case clientCredentials = "client_credentials"
	case urlencoded = "application/x-www-form-urlencoded"
   
}

public enum Keys: String {
	case accept = "Accept"
	case contentType = "Content-Type"
	case clientID = "ClientID"
	case clientSecret = "ClientSecret"
	case accessToken = "Authorization"
	case directFlights = "directFlights"
   case limit = "limit"
	case offset = "offset"
	case client_id = "client_id"
	case client_secret = "client_secret"
	case grant_type = "grant_type"
}

public enum HTTPMethods : String {
	case get = "GET"
	case post = "POST"
}




