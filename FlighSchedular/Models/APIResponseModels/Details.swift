// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let details = try? newJSONDecoder().decode(Details.self, from: jsonData)

import Foundation

// MARK: - Details
struct Details: Codable {
    let stops: Stops?
    let daysOfOperation: Int?
    let datePeriod: DatePeriod?

    enum CodingKeys: String, CodingKey {
        case stops = "Stops"
        case daysOfOperation = "DaysOfOperation"
        case datePeriod = "DatePeriod"
    }
}
