//
//  ATProtoRepoCreateRecordRequestBody.swift
//
//
//  Created by Christopher Head on 2/7/24.
//

public struct ATProtoRepoCreateRecordRequestBody<Record: Encodable>: Encodable {
    public let repo: String
    public let collection: String
    public let record: Record

    public init(repo: String, collection: String, record: Record) {
        self.repo = repo
        self.collection = collection
        self.record = record
    }
}
