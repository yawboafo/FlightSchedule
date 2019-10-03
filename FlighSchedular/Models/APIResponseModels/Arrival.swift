// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let arrival = try? newJSONDecoder().decode(Arrival.self, from: jsonData)

import Foundation

// MARK: - Arrival
struct Arrival: Codable {
    let airportCode: String?
    let scheduledTimeLocal: ScheduledTimeLocal?
    let terminal: Terminal?

    enum CodingKeys: String, CodingKey {
        case airportCode = "AirportCode"
        case scheduledTimeLocal = "ScheduledTimeLocal"
        case terminal = "Terminal"
    }
}
