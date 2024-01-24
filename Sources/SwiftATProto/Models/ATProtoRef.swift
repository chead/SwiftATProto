//
//  ATProtoRef.swift
//
//
//  Created by Christopher Head on 1/24/24.
//

import Foundation

//public enum BlueskyRichtextFacetFeaturesType: Decodable {
//    private enum FieldType: String, Decodable {
//        case blueskyRichtextFacetMention = "#mention"
//        case blueskyRichtextFacetLink = "#link"
//    }
//
//    private enum CodingKeys: String, CodingKey {
//        case type = "$type"
//    }
//
//    case blueskyRichtextFacetMention(BlueskyRichtextFacetMention)
//    case blueskyRichtextFacetLink(BlueskyRichtextFacetLink)
//
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        let fieldType = try container.decode(FieldType.self, forKey: .type)
//
//        let singleValueContainer = try decoder.singleValueContainer()
//
//        switch fieldType {
//        case .blueskyRichtextFacetMention:
//            try self = .blueskyRichtextFacetMention(singleValueContainer.decode(BlueskyRichtextFacetMention.self))
//
//        case .blueskyRichtextFacetLink:
//            try self = .blueskyRichtextFacetLink(singleValueContainer.decode(BlueskyRichtextFacetLink.self))
//        }
//    }
//}

public struct ATProtoRef: Decodable {
    private enum CodingKeys: String, CodingKey {
        case link = "$link"
    }

    public let link: String
}
