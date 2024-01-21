//
//  ATProtoRefreshSessionResponseBody.swift
//  
//
//  Created by Christopher Head on 7/29/23.
//

import Foundation

public struct ATProtoRefreshSessionResponseBody: Decodable {
    public let did: String
    public let handle: String
    public let accessJwt: String
    public let refreshJwt: String

    public init(did: String, handle: String, accessJwt: String, refreshJwt: String) {
        self.did = did
        self.handle = handle
        self.accessJwt = accessJwt
        self.refreshJwt = refreshJwt
    }
}
