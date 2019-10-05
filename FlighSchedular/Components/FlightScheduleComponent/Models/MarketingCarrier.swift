

import Foundation
struct MarketingCarrier : Codable {
	let airlineID : String?
	let flightNumber : Int?

	enum CodingKeys: String, CodingKey {

		case airlineID = "AirlineID"
		case flightNumber = "FlightNumber"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		airlineID = try values.decodeIfPresent(String.self, forKey: .airlineID)
		flightNumber = try values.decodeIfPresent(Int.self, forKey: .flightNumber)
	}

}
