import XCTest
import SwiftLexicon
@testable import SwiftATProto

struct CreateSessionBody: Encodable {
    let identifier: String
    let password: String
}

struct CreateSessionResponse: Decodable {
    let did: String
}

final class SwiftATProtoTests: XCTestCase {
    @available(iOS 16.0, *)
    func testExample() async throws {
        let createSessionJSON =
        """
        {
          "lexicon": 1,
          "id": "com.atproto.server.createSession",
          "defs": {
            "main": {
              "type": "procedure",
              "description": "Create an authentication session.",
              "input": {
                "encoding": "application/json",
                "schema": {
                  "type": "object",
                  "required": [
                    "identifier",
                    "password"
                  ],
                  "properties": {
                    "identifier": {
                      "type": "string",
                      "description": "Handle or other identifier supported by the server for the authenticating user."
                    },
                    "password": {
                      "type": "string"
                    }
                  }
                }
              },
              "output": {
                "encoding": "application/json",
                "schema": {
                  "type": "object",
                  "required": [
                    "accessJwt",
                    "refreshJwt",
                    "handle",
                    "did"
                  ],
                  "properties": {
                    "accessJwt": {
                      "type": "string"
                    },
                    "refreshJwt": {
                      "type": "string"
                    },
                    "handle": {
                      "type": "string",
                      "format": "handle"
                    },
                    "did": {
                      "type": "string",
                      "format": "did"
                    },
                    "email": {
                      "type": "string"
                    }
                  }
                }
              },
              "errors": [
                {
                  "name": "AccountTakedown"
                }
              ]
            }
          }
        }
        """.data(using: .utf8)!
        
        let createSessionLexicon = try! JSONDecoder().decode(Lexicon.self, from: createSessionJSON)

        if let mainDef = createSessionLexicon.defs["main"] {
            switch mainDef {
            case .procedure(let procedure):
                let createSessionBody = CreateSessionBody(identifier: "", password: "")
                
                let request = try ATProtoHTTPRequest(host: URL(string: "")!, nsid: createSessionLexicon.id, parameters: [:], body: createSessionBody, requestable: procedure)

                let response: Result<CreateSessionResponse, Error> = try await ATProtoHTTPClient().make(request: request)

                break
            default:
                break
            }
        }

        XCTAssertEqual(createSessionLexicon.id, "com.atproto.server.createSession")
    }
}
