//
//  ATProtoBlobTests.swift
//
//
//  Created by Christopher Head on 1/24/24.
//

import XCTest
import SwiftLexicon
@testable import SwiftATProto

final class ATProtoBlobTests: XCTestCase {
    func testDecodeFromJSON() throws {
        let atProtoBlobJSONData = """
        {
            "$type": "blob",
            "ref": {
                "$link": "bafkreiertzz7w3qgslvm2lyxy7tae3pcmg6jr5phrbbkhmneb22wkc6vum"
            },
            "mimeType": "image/jpeg",
            "size": 308992
        }
        """.data(using: .utf8)!

        _ = try JSONDecoder().decode(ATProtoBlob.self, from: atProtoBlobJSONData)
    }
}
