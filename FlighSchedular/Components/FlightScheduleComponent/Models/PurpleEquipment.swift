// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let purpleEquipment = try? newJSONDecoder().decode(PurpleEquipment.self, from: jsonData)

import Foundation

// MARK: - PurpleEquipment
struct PurpleEquipment: Codable {
    let aircraftCode: String?

    enum CodingKeys: String, CodingKey {
        case aircraftCode = "AircraftCode"
    }
}
