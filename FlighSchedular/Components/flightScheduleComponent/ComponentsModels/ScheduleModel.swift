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


extension ScheduleModel {
	var readableDuration: String{
		var duration = ""
		let day = self.journeyTime?.slice(from: "P", to: "D")
		let hours = self.journeyTime?.slice(from: "T", to: "H")
		let minutes = self.journeyTime?.slice(from: "H", to: "M")
		
		if let _day = day {
			duration.append("\(Int(_day)?.describe(trailingString: "day") ?? "") ")
		}
		if let _hours = hours {
			duration.append(" \(Int(_hours)?.describe(trailingString: "Hour") ?? "")")
		}
		if let _minute = minutes {
			duration.append(" \(Int(_minute)?.describe(trailingString: "Minute") ?? "") ")
		}

		return duration
	}
}

