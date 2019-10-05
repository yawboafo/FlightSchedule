// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let scheduleResourceClass = try? newJSONDecoder().decode(ScheduleResourceClass.self, from: jsonData)

import Foundation

// MARK: - ScheduleResourceClass
struct ScheduleResourceClass: Codable {
    let schedule: [Schedule]?
    let meta: Meta?

    enum CodingKeys: String, CodingKey {
        case schedule = "Schedule"
        case meta = "Meta"
    }
}
