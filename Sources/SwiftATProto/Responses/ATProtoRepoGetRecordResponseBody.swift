//
//  ATProtoRepoGetRecordResponseBody.swift
//  SwiftATProto
//
//  Created by Christopher Head on 11/1/24.
//

public struct ATProtoRepoGetRecordResponseBody<Record: Decodable>: Decodable {
    public let uri: String
    public let cid: String?
    public let value: Record
}
