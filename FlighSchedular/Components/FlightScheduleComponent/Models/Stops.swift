
import Foundation
struct Stops : Codable {
	let stopQuantity : Int?

	enum CodingKeys: String, CodingKey {

		case stopQuantity = "StopQuantity"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		stopQuantity = try values.decodeIfPresent(Int.self, forKey: .stopQuantity)
	}

}
