//
//  ATProtoCreateSessionRequestBody.swift
//  
//
//  Created by Christopher Head on 7/28/23.
//

import Foundation

public struct ATProtoCreateSessionRequestBody: Encodable {
    public let identifier: String
    public let password: String

    public init(identifier: String, password: String) {
        self.identifier = identifier
        self.password = password
    }
}
