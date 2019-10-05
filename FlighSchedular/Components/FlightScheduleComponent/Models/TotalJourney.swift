

import Foundation
struct TotalJourney : Codable {
	let duration : String?

	enum CodingKeys: String, CodingKey {

		case duration = "Duration"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		duration = try values.decodeIfPresent(String.self, forKey: .duration)
	}

}
