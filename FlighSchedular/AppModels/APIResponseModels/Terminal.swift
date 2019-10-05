// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let terminal = try? newJSONDecoder().decode(Terminal.self, from: jsonData)

import Foundation

// MARK: - Terminal
struct Terminal: Codable {
    let name: Name?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
    }
}



enum Name: Codable {
    case string(String)
    case int(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(Int.self) {
            self = .int(x)
            return
        }
        throw DecodingError.typeMismatch(FlightUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for FlightUnion"))
    }

	func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .int(let x):
            try container.encode(x)
        }
    }
}



extension Terminal{
	var descriptionValue : String{
		let data = try? JSONEncoder().encode(self.name)
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
