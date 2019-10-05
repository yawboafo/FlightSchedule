

import Foundation
struct Arrival : Codable {
	let airportCode : String?
	let scheduledTimeLocal : ScheduledTimeLocal?
	let terminal : Terminal?

	enum CodingKeys: String, CodingKey {

		case airportCode = "AirportCode"
		case scheduledTimeLocal = "ScheduledTimeLocal"
		case terminal = "Terminal"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		airportCode = try values.decodeIfPresent(String.self, forKey: .airportCode)
		scheduledTimeLocal = try values.decodeIfPresent(ScheduledTimeLocal.self, forKey: .scheduledTimeLocal)
		terminal = try values.decodeIfPresent(Terminal.self, forKey: .terminal)
	}

}
