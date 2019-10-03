// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let fluffyEquipment = try? newJSONDecoder().decode(FluffyEquipment.self, from: jsonData)

import Foundation

// MARK: - FluffyEquipment
struct Equipment: Codable {
    let aircraftCode: AircraftCode?

    enum CodingKeys: String, CodingKey {
        case aircraftCode = "AircraftCode"
    }
}
