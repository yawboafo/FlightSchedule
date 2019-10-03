//
//  ScheduleModel.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 02/10/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
class ScheduleModel: NSObject {
	
	var journeyTime : String?
	var totalTransits : String?
	
	init(schedule : Schedule) {
		super.init()
		journeyTime = schedule.totalJourney?.duration ?? ""
		totalTransits = "\(schedule.flightElements.count)"
		
	}
}

