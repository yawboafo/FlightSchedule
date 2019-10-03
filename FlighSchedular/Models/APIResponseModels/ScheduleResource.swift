// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let scheduleResource = try? newJSONDecoder().decode(ScheduleResource.self, from: jsonData)

import Foundation

// MARK: - ScheduleResource
struct ScheduleResource: Codable {
   let schedule: [Schedule]?
    let meta: Meta?

    enum CodingKeys: String, CodingKey {
        case schedule = "Schedule"
        case meta = "Meta"
    }
}
