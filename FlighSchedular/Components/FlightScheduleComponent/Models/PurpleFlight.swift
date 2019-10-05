// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let purpleFlight = try? newJSONDecoder().decode(PurpleFlight.self, from: jsonData)

import Foundation

// MARK: - PurpleFlight
struct PurpleFlight: Codable {
    let departure: Departure?
    let arrival: Arrival?
    let marketingCarrier: MarketingCarrier?
    let operatingCarrier: OperatingCarrier?
    let equipment: FluffyEquipment?
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
