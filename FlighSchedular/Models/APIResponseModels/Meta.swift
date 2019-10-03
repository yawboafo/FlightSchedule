// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let meta = try? newJSONDecoder().decode(Meta.self, from: jsonData)

import Foundation

// MARK: - Meta
struct Meta: Codable {
    let version: String?
    let link: [Link]?

    enum CodingKeys: String, CodingKey {
        case version = "@Version"
        case link = "Link"
    }
}
