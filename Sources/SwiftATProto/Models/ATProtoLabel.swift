//
//  ATProtoLabel.swift
//
//
//  Created by Christopher Head on 1/21/24.
//

import Foundation

public struct ATProtoLabel: Decodable {
    let src: String
    let uri: String
    let cid: String
    let val: String
    let neg: Bool
    let cts: String

    public init(src: String, uri: String, cid: String, val: String, neg: Bool, cts: String) {
        self.src = src
        self.uri = uri
        self.cid = cid
        self.val = val
        self.neg = neg
        self.cts = cts
    }
}
