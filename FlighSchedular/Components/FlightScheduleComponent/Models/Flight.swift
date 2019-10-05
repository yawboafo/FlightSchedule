

import Foundation
struct Flight : Codable {
	let departure : Departure?
	let arrival : Arrival?
	let marketingCarrier : MarketingCarrier?
	let operatingCarrier : OperatingCarrier?
	let equipment : Equipment?
	let details : Details?

	enum CodingKeys: String, CodingKey {

		case departure = "Departure"
		case arrival = "Arrival"
		case marketingCarrier = "MarketingCarrier"
		case operatingCarrier = "OperatingCarrier"
		case equipment = "Equipment"
		case details = "Details"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		departure = try values.decodeIfPresent(Departure.self, forKey: .departure)
		arrival = try values.decodeIfPresent(Arrival.self, forKey: .arrival)
		marketingCarrier = try values.decodeIfPresent(MarketingCarrier.self, forKey: .marketingCarrier)
		operatingCarrier = try values.decodeIfPresent(OperatingCarrier.self, forKey: .operatingCarrier)
		equipment = try values.decodeIfPresent(Equipment.self, forKey: .equipment)
		details = try values.decodeIfPresent(Details.self, forKey: .details)
	}

}
