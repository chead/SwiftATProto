//
//  ATProtoLabel.swift
//
//
//  Created by Christopher Head on 1/21/24.
//

import Foundation

public struct ATProtoLabel: Codable {
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
