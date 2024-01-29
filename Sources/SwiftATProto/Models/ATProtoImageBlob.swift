//
//  ATProtoImageBlob.swift
//
//
//  Created by Christopher Head on 1/29/24.
//

// Support for legacy Image Blobs

import Foundation

public struct ATProtoImageBlobImage: Decodable {
    public let cid: String
    public let mimeType: String
}

public struct ATProtoImageBlob: Decodable {
    public let alt: String
    public let image: ATProtoImageBlobImage
}
