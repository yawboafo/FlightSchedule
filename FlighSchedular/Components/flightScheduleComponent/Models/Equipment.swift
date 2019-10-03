

import Foundation
struct Equipment : Codable {
	let aircraftCode : AircraftCode?

	enum CodingKeys: String, CodingKey {

		case aircraftCode = "AircraftCode"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		aircraftCode = try values.decodeIfPresent(AircraftCode.self, forKey: .aircraftCode)
	}

}

enum AircraftCode: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(AircraftCode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AircraftCode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
