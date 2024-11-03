//
//  ATProtoBlob.swift
//
//
//  Created by Christopher Head on 1/24/24.
//

import Foundation

public struct ATProtoBlob: Codable {
    private enum CodingKeys: String, CodingKey {
        case type = "$type"
        case ref
        case mimeType
        case size
    }

    public let ref: ATProtoRef
    public let mimeType: String
    public let size: Int

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.ref = try container.decode(ATProtoRef.self, forKey: .ref)
        self.mimeType = try container.decode(String.self, forKey: .mimeType)
        self.size = try container.decode(Int.self, forKey: .size)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode("blob", forKey: .type)
        try container.encode(ref, forKey: .ref)
        try container.encode(mimeType, forKey: .mimeType)
        try container.encode(size, forKey: .size)
    }
}
