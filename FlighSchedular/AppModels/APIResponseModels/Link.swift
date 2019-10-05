// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let link = try? newJSONDecoder().decode(Link.self, from: jsonData)

import Foundation

// MARK: - Link
struct Link: Codable {
    let href: String?
    let rel: String?

    enum CodingKeys: String, CodingKey {
        case href = "@Href"
        case rel = "@Rel"
    }
}
