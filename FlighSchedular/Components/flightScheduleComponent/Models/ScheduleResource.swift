
import Foundation
struct ScheduleResource : Codable {
	let schedule : [Schedule]?
	let meta : Meta?

	enum CodingKeys: String, CodingKey {

		case schedule = "Schedule"
		case meta = "Meta"
		
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		schedule = try values.decodeIfPresent([Schedule].self, forKey: .schedule)
		meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
	}

}
