//
//  ATProtoImageBlob.swift
//
//
//  Created by Christopher Head on 1/29/24.
//

// Support for legacy Image Blobs

import Foundation

public struct ATProtoImageBlob: Hashable, Codable {
    public let cid: String
    public let mimeType: String
}
