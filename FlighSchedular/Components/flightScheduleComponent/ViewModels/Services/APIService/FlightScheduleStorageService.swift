//
//  ScheduleStorageService.swift
//  AirLineSchedular
//
//  Created by Engineer 144 on 28/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
class FlightScheduleStorageService {
	
     let mainBundle = Bundle.main
	
	var token : Token{
		set{ try? cache.saveData(data: newValue, key: "Token") }
		get{ return try? cache.getData(key: "Token") }
	}
	
	var localAITA : Iata?{
		get { return try? IATAlocal() }
	}
	
	
  func IATAlocal() throws -> Iata?{
	   let fileName = "ITTACodes"
	   guard let filePath = mainBundle.path(forResource: "IATA.bundle/\(fileName)", ofType: ".json") else { throw DataCacheError.unknownPath }
		  let data = try? Data(contentsOf: URL(fileURLWithPath: filePath), options: .alwaysMapped)
		  guard let _data = data else { throw DataCacheError.dataNil  }
		  let airports = try? JSONDecoder().decode(Iata.self, from: _data)
		  return airports
		
	}
}


