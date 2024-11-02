//
//  ATProtoRepoPutRecordRequestBody.swift
//  SwiftATProto
//
//  Created by Christopher Head on 11/1/24.
//

public struct ATProtoRepoPutRecordRequestBody<Record: Encodable>: Encodable {
    public let repo: String
    public let collection: String
    public let rkey: String
    public let validate: Bool?
    public let record: Record
    public let swapRecord: String?
    public let swapCommit: String?

    public init(repo: String, collection: String, rkey: String, validate: Bool?, record: Record, swapRecord: String?, swapCommit: String?) {
        self.repo = repo
        self.collection = collection
        self.rkey = rkey
        self.validate = validate
        self.record = record
        self.swapRecord = swapRecord
        self.swapCommit = swapCommit
    }
}
