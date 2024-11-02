//
//  ATProtoRepoPutRecordResponseBody.swift
//  SwiftATProto
//
//  Created by Christopher Head on 11/1/24.
//

public enum ATProtoRepoPutRecordValidationStatus: String {
    case valid
    case unknown
}

public struct ATProtoRepoPutRecordResponseBody: Decodable {
    public let uri: String
    public let cid: String
    public let commit: ATProtoRepoCommitMeta?
    public let validationStatus: String
}
