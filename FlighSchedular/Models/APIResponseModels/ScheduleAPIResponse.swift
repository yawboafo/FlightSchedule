
import Foundation
struct ScheduleAPIResponse : Codable {
	let scheduleResource : ScheduleResource?

	enum CodingKeys: String, CodingKey {

		case scheduleResource = "ScheduleResource"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		scheduleResource = try values.decodeIfPresent(ScheduleResource.self, forKey: .scheduleResource)
	}

}
