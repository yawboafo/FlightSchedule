

import Foundation
struct Meta : Codable {
	let version : String?
	let link : [Link]?

	enum CodingKeys: String, CodingKey {

		case version = "@Version"
		case link = "Link"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		version = try values.decodeIfPresent(String.self, forKey: .version)
		link = try values.decodeIfPresent([Link].self, forKey: .link)
	}

}
