import Foundation

enum FlightUnion: Codable {
    case flightElementArray([FlightElement])
    case purpleFlight(PurpleFlight)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([FlightElement].self) {
            self = .flightElementArray(x)
            return
        }
        if let x = try? container.decode(PurpleFlight.self) {
            self = .purpleFlight(x)
            return
        }
        throw DecodingError.typeMismatch(FlightUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for FlightUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .flightElementArray(let x):
            try container.encode(x)
        case .purpleFlight(let x):
            try container.encode(x)
        }
    }
}
