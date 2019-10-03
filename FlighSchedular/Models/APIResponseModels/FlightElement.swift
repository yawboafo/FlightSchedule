// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let flightElement = try? newJSONDecoder().decode(FlightElement.self, from: jsonData)

import Foundation

// MARK: - FlightElement
struct FlightElement: Codable {
    let departure: Departure?
    let arrival: Arrival?
    let marketingCarrier: MarketingCarrier?
    let operatingCarrier: OperatingCarrier?
    let equipment: Equipment?
    let details: Details?

    enum CodingKeys: String, CodingKey {
        case departure = "Departure"
        case arrival = "Arrival"
        case marketingCarrier = "MarketingCarrier"
        case operatingCarrier = "OperatingCarrier"
        case equipment = "Equipment"
        case details = "Details"
    }
}
