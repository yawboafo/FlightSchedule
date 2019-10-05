import Foundation

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

extension Equipment{
	var descriptionValue : String{
		let data = try? JSONEncoder().encode(self.aircraftCode)
		guard let _data = data else { return  "Not Specified" }
		do{
			let decoder = try JSONDecoder().decode(String.self, from: _data)
			return decoder
		}catch{
			let decoder = try? JSONDecoder().decode(Int.self, from: _data)
			
			return decoder?.description ?? "Not Specified"
		}
		
	}
}
