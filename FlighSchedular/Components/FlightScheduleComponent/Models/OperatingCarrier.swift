

import Foundation
struct OperatingCarrier : Codable {
	let airlineID : String?

	enum CodingKeys: String, CodingKey {

		case airlineID = "AirlineID"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		airlineID = try values.decodeIfPresent(String.self, forKey: .airlineID)
	}

}
