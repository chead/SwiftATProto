//
//  ATProtoLabel.swift
//
//
//  Created by Christopher Head on 1/21/24.
//

import Foundation

public struct ATProtoLabel: Hashable, Codable {
    public let src: String
    public let uri: String
    public let cid: String?
    public let val: String
    public let neg: Bool?
    public let cts: String

    public init(src: String, uri: String, cid: String?, val: String, neg: Bool?, cts: String) {
        self.src = src
        self.uri = uri
        self.cid = cid
        self.val = val
        self.neg = neg
        self.cts = cts
    }
}

public struct ATProtoSelfLabel: Hashable, Codable {
    public let val: String
}

public struct ATProtoSelfLabels: Hashable, Codable {
    private enum CodingKeys: String, CodingKey {
        case type = "$type"
        case values
    }

    public let values: [ATProtoSelfLabel]

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.values = try container.decode([ATProtoSelfLabel].self, forKey: .values)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode("com.atproto.label.defs#selfLabels", forKey: .type)
        try container.encode(values, forKey: .values)
    }
}
