//
//  File.swift
//  
//
//  Created by Christopher Head on 2/7/24.
//

import Foundation

public struct ATProtoRepoDeleteRecordRequestBody: Encodable {
    public let repo: String
    public let collection: String
    public let rkey: String

    public init(repo: String, collection: String, rkey: String) {
        self.repo = repo
        self.collection = collection
        self.rkey = rkey
    }
}
