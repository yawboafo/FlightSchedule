// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let departure = try? newJSONDecoder().decode(Departure.self, from: jsonData)

import Foundation

// MARK: - Departure
struct Departure: Codable {
    let airportCode: String?
    let scheduledTimeLocal: ScheduledTimeLocal?
  	let terminal: Terminal?

    enum CodingKeys: String, CodingKey {
        case airportCode = "AirportCode"
        case scheduledTimeLocal = "ScheduledTimeLocal"
		 case terminal = "Terminal"

    }
}
