//
//  ATProtoBlob.swift
//
//
//  Created by Christopher Head on 1/24/24.
//

import Foundation

public struct ATProtoBlob: Codable {
    public let ref: ATProtoRef
    public let mimeType: String
    public let size: Int
}
