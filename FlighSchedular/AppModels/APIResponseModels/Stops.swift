// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let stops = try? newJSONDecoder().decode(Stops.self, from: jsonData)

import Foundation

// MARK: - Stops
struct Stops: Codable {
    let stopQuantity: Int?

    enum CodingKeys: String, CodingKey {
        case stopQuantity = "StopQuantity"
    }
}
