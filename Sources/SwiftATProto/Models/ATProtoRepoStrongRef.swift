//
//  ATProtoRepoStrongRef.swift
//  
//
//  Created by Christopher Head on 7/30/23.
//

import Foundation

public struct ATProtoRepoStrongRef: Decodable {
    let uri: String
    let cid: String

    public init(uri: String, cid: String) {
        self.uri = uri
        self.cid = cid
    }
}
