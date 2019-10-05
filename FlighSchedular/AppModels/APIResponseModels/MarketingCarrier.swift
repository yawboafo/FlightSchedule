// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let marketingCarrier = try? newJSONDecoder().decode(MarketingCarrier.self, from: jsonData)

import Foundation

// MARK: - MarketingCarrier
struct MarketingCarrier: Codable {
    let airlineID: String?
    let flightNumber: Int?

    enum CodingKeys: String, CodingKey {
        case airlineID = "AirlineID"
        case flightNumber = "FlightNumber"
    }
}
