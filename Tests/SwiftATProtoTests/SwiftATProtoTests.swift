import XCTest
import SwiftLexicon
@testable import SwiftATProto

struct CreateSessionBody: Encodable {
    let identifier: String
    let password: String
}

struct CreateSessionResponse: Decodable {
    let did: String
    let handle: String
    let accessJwt: String
    let refreshJwt: String
}

final class SwiftATProtoTests: XCTestCase {
    @available(iOS 16.0, *)
    func testCreateSession() async throws {
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
                
                let request = try ATProtoHTTPRequest(host: URL(string: "")!, nsid: createSessionLexicon.id, parameters: [:], body: createSessionBody, token: nil, requestable: procedure)

                let response: Result<CreateSessionResponse, ATProtoHTTPClientError> = await ATProtoHTTPClient().make(request: request)

                switch(response) {
                case .success(let createSessionResponse):
                    break
                
                case .failure(let error):
                    break
                }
            default:
                break
            }
        }

        XCTAssertEqual(createSessionLexicon.id, "com.atproto.server.createSession")
    }

    @available(iOS 16.0, *)
    func testGetProfiles() async throws {
        let getProfilesJSON =
        """
        {
          "lexicon": 1,
          "id": "app.bsky.actor.getProfiles",
          "defs": {
            "main": {
              "type": "query",
              "parameters": {
                "type": "params",
                "required": [
                  "actors"
                ],
                "properties": {
                  "actors": {
                    "type": "array",
                    "items": {
                      "type": "string",
                      "format": "at-identifier"
                    },
                    "maxLength": 25
                  }
                }
              },
              "output": {
                "encoding": "application/json",
                "schema": {
                  "type": "object",
                  "required": [
                    "profiles"
                  ],
                  "properties": {
                    "profiles": {
                      "type": "array",
                      "items": {
                        "type": "ref",
                        "ref": "app.bsky.actor.defs#profileViewDetailed"
                      }
                    }
                  }
                }
              }
            }
          }
        }

        """.data(using: .utf8)!
        
        let getProfilesLexicon = try! JSONDecoder().decode(Lexicon.self, from: getProfilesJSON)
        
        struct EmptyBody: Encodable {}
        struct GetProfilesResponseBody: Decodable {}
        
        if let mainDef = getProfilesLexicon.defs["main"] {
            switch mainDef {
            case .query(let query):
                let getProfilesRequest = try ATProtoHTTPRequest(host: URL(string: "")!, nsid: getProfilesLexicon.id, parameters: ["actors":["foobar"]], body: nil, token: "", requestable: query)

                let getProfilesResponse: Result<GetProfilesResponseBody, ATProtoHTTPClientError> = await ATProtoHTTPClient().make(request: getProfilesRequest)

                switch(getProfilesResponse) {
                case .success(let getProfilesResponseBody):
                    break
                
                case .failure(let error):
                    break
                }

            default:
                break
            }
        }

        XCTAssertEqual(getProfilesLexicon.id, "app.bsky.actor.getProfiles")
    }
}
