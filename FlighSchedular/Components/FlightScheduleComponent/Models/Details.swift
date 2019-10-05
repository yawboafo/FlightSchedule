
import Foundation
struct Details : Codable {
	let stops : Stops?
	let daysOfOperation : Int?
	let datePeriod : DatePeriod?

	enum CodingKeys: String, CodingKey {

		case stops = "Stops"
		case daysOfOperation = "DaysOfOperation"
		case datePeriod = "DatePeriod"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		stops = try values.decodeIfPresent(Stops.self, forKey: .stops)
		daysOfOperation = try values.decodeIfPresent(Int.self, forKey: .daysOfOperation)
		datePeriod = try values.decodeIfPresent(DatePeriod.self, forKey: .datePeriod)
	}

}
