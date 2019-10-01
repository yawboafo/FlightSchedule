//
//  ScheduleStorageService.swift
//  AirLineSchedular
//
//  Created by Engineer 144 on 28/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
class FlightScheduleStorageService {
	
	var token : Token{
		set{ try? cache.saveData(data: newValue, key: "Token") }
		get{ return try? cache.getData(key: "Token") }
	}
	
}


