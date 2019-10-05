

import Foundation
struct Terminal : Codable {
	let name : Int?

	enum CodingKeys: String, CodingKey {

		case name = "Name"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(Int.self, forKey: .name)
	}

}
