

import Foundation
struct ScheduledTimeLocal : Codable {
	let dateTime : String?

	enum CodingKeys: String, CodingKey {

		case dateTime = "DateTime"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
	}

}
