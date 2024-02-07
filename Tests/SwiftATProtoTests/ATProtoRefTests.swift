//
//  ATProtoRefTests.swift
//  
//
//  Created by Christopher Head on 1/24/24.
//

import XCTest
import SwiftLexicon
@testable import SwiftATProto

final class ATProtoRefTests: XCTestCase {
    func testDecodeFromJSON() throws {
        let atProtoRefJSONData = """
        {
            "$link": "bafkreiertzz7w3qgslvm2lyxy7tae3pcmg6jr5phrbbkhmneb22wkc6vum"
        }
        """.data(using: .utf8)!

        _ = try JSONDecoder().decode(ATProtoRef.self, from: atProtoRefJSONData)
    }
}
