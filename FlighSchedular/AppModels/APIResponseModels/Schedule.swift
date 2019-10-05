// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let schedule = try? newJSONDecoder().decode(Schedule.self, from: jsonData)

import Foundation

// MARK: - Schedule
struct Schedule: Codable {
    let totalJourney: TotalJourney?
	 let flight:FlightUnion?

	
    enum CodingKeys: String, CodingKey {
        case totalJourney = "TotalJourney"
        case flight = "Flight"
    }
}


extension Schedule{
	var flightElements : [FlightElement]{
		let data = try? JSONEncoder().encode(self.flight)
		guard let _data = data else { return [] }
		do{
			let decoder = try JSONDecoder().decode([FlightElement].self, from: _data)
			return decoder 
		}catch{
			let decoder = try? JSONDecoder().decode(FlightElement.self, from: _data)
			var elements  : [FlightElement]  = []
			guard let _decoder = decoder else { return elements }
			elements.append(_decoder)
			return elements
		}
		
	}
}
