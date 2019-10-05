
import Foundation
struct Departure : Codable {
	let airportCode : String?
	let scheduledTimeLocal : ScheduledTimeLocal?

	enum CodingKeys: String, CodingKey {

		case airportCode = "AirportCode"
		case scheduledTimeLocal = "ScheduledTimeLocal"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		airportCode = try values.decodeIfPresent(String.self, forKey: .airportCode)
		scheduledTimeLocal = try values.decodeIfPresent(ScheduledTimeLocal.self, forKey: .scheduledTimeLocal)
	}

}
