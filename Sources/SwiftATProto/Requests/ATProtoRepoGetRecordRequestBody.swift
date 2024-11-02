//
//  ATProtoRepoGetRecordRequestBody.swift
//  SwiftATProto
//
//  Created by Christopher Head on 11/1/24.
//

public struct ATProtoRepoGetRecordRequestBody: Encodable {
    public let repo: String
    public let collection: String
    public let rkey: String
    public let cid: String?

    public init(repo: String, collection: String, rkey: String, cid: String?) {
        self.repo = repo
        self.collection = collection
        self.rkey = rkey
        self.cid = cid
    }
}
