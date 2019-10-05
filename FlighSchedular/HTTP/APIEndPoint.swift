//
//  APIEndPoint.swift
//  AirLineSchedular
//
//  Created by Engineer 144 on 28/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
struct APIEndPoint {
	
	static let baseURL : String = "https://api.lufthansa.com/v1"
	enum URLPath : String{
		case operations = "/operations"
		case schedules = "/schedules"
		case oauth = "/oauth"
		case token = "/token"
	}
	
	
	
	static func buildStringURL(base:String = baseURL,
										urlPaths:[URLPath] = [],
										otherPaths:[String] = []) -> String?{
		let endpoint: String = base
		let path = urlPaths.compactMap{ args in args.rawValue }.joined()
		let otherPath  = otherPaths.joined(separator: "/")
		return [endpoint,path,"/",otherPath].joined()
		
		
	}
}


