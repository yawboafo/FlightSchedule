// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let scheduledTimeLocal = try? newJSONDecoder().decode(ScheduledTimeLocal.self, from: jsonData)

import Foundation

// MARK: - ScheduledTimeLocal
struct ScheduledTimeLocal: Codable {
    let dateTime: String?

    enum CodingKeys: String, CodingKey {
        case dateTime = "DateTime"
    }
}
