import Foundation
import SwiftLexicon

enum ATProtoHTTPRequestError: String, Error {
    case requiredParameters
    case invalidParameter
    case invalidMethod
}

public struct ATProtoHTTPRequest {
    public let urlRequest: URLRequest

    @available(iOS 16.0, *)
    public init(host: URL, nsid: String, parameters: [String : Any], body: Encodable?, token: String?, requestable: LexiconHTTPRequestable) throws {
        var url = host.appending(component: "xrpc").appending(path: nsid)

        if let requiredParameters = requestable.parameters?.required {
            for parameter in requiredParameters {
                if !parameters.keys.contains([parameter]) {
                    throw ATProtoHTTPRequestError.requiredParameters
                }

                if let properties = requestable.parameters?.properties {
                    for property in properties {
                        switch(property.value) {
                        case .boolean(_) where parameters[property.key] is Bool:
                            if let booleanParameter = parameters[property.key] as? Bool {
                                url.append(queryItems: [URLQueryItem(name: property.key, value: String(booleanParameter))])
                            } else {
                                throw ATProtoHTTPRequestError.invalidParameter
                            }

                        case .integer(_):
                            if let integerParameter = parameters[property.key] as? Int {
                                url.append(queryItems: [URLQueryItem(name: property.key, value: String(integerParameter))])
                            } else {
                                throw ATProtoHTTPRequestError.invalidParameter
                            }

                        case .string(_), .unknown(_):
                            if let stringParameter = parameters[property.key] as? String {
                                url.append(queryItems: [URLQueryItem(name: property.key, value: stringParameter)])
                            } else {
                                throw ATProtoHTTPRequestError.invalidParameter
                            }

                        case .array(_):
                            if let arrayParameters = parameters[property.key] as? [Any] {
                                for arrayParameter in arrayParameters {
                                    switch arrayParameter {
                                    case let boolean as Bool:
                                        url.append(queryItems: [URLQueryItem(name: property.key, value: String(boolean))])

                                    case let integer as Int:
                                        url.append(queryItems: [URLQueryItem(name: property.key, value: String(integer))])

                                    case let string as String:
                                        url.append(queryItems: [URLQueryItem(name: property.key, value: string)])

                                    default:
                                        throw ATProtoHTTPRequestError.invalidParameter
                                    }
                                }
                            } else {
                                throw ATProtoHTTPRequestError.invalidParameter
                            }

                        default:
                            throw ATProtoHTTPRequestError.invalidParameter
                        }
                    }
                }
            }
        }
        
        var newURLRequest = URLRequest(url: url)

        if let encoding = requestable.input?.encoding {
            newURLRequest.setValue(encoding, forHTTPHeaderField: "Content-Type")
        }

        if let token = token {
            newURLRequest.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        switch requestable {
        case is LexiconQuery:
            newURLRequest.httpMethod = "GET"

        case is LexiconProcedure:
            newURLRequest.httpMethod = "POST"

        default:
            throw ATProtoHTTPRequestError.invalidMethod
        }

        if let body = body {
            let httpBody = try! JSONEncoder().encode(body)
            
            newURLRequest.httpBody = httpBody
        }

        urlRequest = newURLRequest
    }
}
