
import Foundation
struct DatePeriod : Codable {
	let effective : String?
	let expiration : String?

	enum CodingKeys: String, CodingKey {

		case effective = "Effective"
		case expiration = "Expiration"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		effective = try values.decodeIfPresent(String.self, forKey: .effective)
		expiration = try values.decodeIfPresent(String.self, forKey: .expiration)
	}

}
