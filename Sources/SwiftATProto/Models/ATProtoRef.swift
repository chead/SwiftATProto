//
//  ATProtoRef.swift
//
//
//  Created by Christopher Head on 1/24/24.
//

import Foundation

public struct ATProtoRef: Codable {
    private enum CodingKeys: String, CodingKey {
        case link = "$link"
    }

    public let link: String
}
