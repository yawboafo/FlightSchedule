// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let datePeriod = try? newJSONDecoder().decode(DatePeriod.self, from: jsonData)

import Foundation

// MARK: - DatePeriod
struct DatePeriod: Codable {
    let effective, expiration: String?

    enum CodingKeys: String, CodingKey {
        case effective = "Effective"
        case expiration = "Expiration"
    }
}
