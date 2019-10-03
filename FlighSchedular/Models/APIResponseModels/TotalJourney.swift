// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let totalJourney = try? newJSONDecoder().decode(TotalJourney.self, from: jsonData)

import Foundation

// MARK: - TotalJourney
struct TotalJourney: Codable {
    let duration: String?

    enum CodingKeys: String, CodingKey {
        case duration = "Duration"
    }
}
