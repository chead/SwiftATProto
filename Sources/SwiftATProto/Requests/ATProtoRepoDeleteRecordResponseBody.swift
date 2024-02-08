//
//  ATProtoRepoDeleteRecordResponseBody.swift
//  
//
//  Created by Christopher Head on 2/7/24.
//

import Foundation

public struct ATProtoRepoDeleteRecordResponseBody: Decodable {
    public init() {}

    public init(from decoder: Decoder) throws {
        self = ATProtoRepoDeleteRecordResponseBody()
    }
}
