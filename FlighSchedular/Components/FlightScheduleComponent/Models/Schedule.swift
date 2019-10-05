// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let schedule = try? newJSONDecoder().decode(Schedule.self, from: jsonData)

import Foundation

// MARK: - Schedule
struct Schedule: Codable {
    let totalJourney: TotalJourney?
    let flight: FlightUnion?

    enum CodingKeys: String, CodingKey {
        case totalJourney = "TotalJourney"
        case flight = "Flight"
    }
}
