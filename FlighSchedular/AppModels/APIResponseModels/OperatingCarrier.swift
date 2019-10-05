// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let operatingCarrier = try? newJSONDecoder().decode(OperatingCarrier.self, from: jsonData)

import Foundation

// MARK: - OperatingCarrier
struct OperatingCarrier: Codable {
    let airlineID: String?

    enum CodingKeys: String, CodingKey {
        case airlineID = "AirlineID"
    }
}
