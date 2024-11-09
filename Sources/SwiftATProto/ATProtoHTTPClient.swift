//
//  ATProtoHTTPClient.swift
//  
//
//  Created by Christopher Head on 7/27/23.
//

import Foundation

public enum ATProtoHTTPClientRequestError: String, Decodable {
    case invalidRequest = "InvalidRequest"
    case expiredToken = "ExpiredToken"
    case invalidToken = "InvalidToken"
}

public enum ATProtoHTTPClientBadRequestType<ATProtoHTTPClientMethodError: Decodable>: Decodable {
    case request(ATProtoHTTPClientRequestError)
    case method(ATProtoHTTPClientMethodError)

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let requestError = try? container.decode(ATProtoHTTPClientRequestError.self) {
            self = .request(requestError)
        } else if let methodError = try? container.decode(ATProtoHTTPClientMethodError.self) {
            self = .method(methodError)
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Could not decode error with type \(ATProtoHTTPClientMethodError.self)."))
        }
    }
}

public enum ATProtoHTTPClientError<ATProtoHTTPClientMethodError: Decodable>: Error {
    case badRequest(error: ATProtoHTTPClientBadRequestType<ATProtoHTTPClientMethodError>, message: String)
    case badResponse(error: Error)
    case noResponse
    case unauthorized
    case forbidden
    case notFound
    case largePayload
    case tooManyRequests
    case internalServerError
    case notImplemented
    case unavailable
    case session(error: Error)
    case unknown(status: Int)
}

public struct ATProtoHTTPClientBadRequestErrorResponse<ATProtoHTTPClientMethodError: Decodable>: Decodable {
    let error: ATProtoHTTPClientBadRequestType<ATProtoHTTPClientMethodError>
    let message: String
}

public class ATProtoHTTPClient {
    @available(iOS 15.0, *)
    public static func make<ATProtoHTTPClientResponse: Decodable, ATProtoHTTPClientMethodError: Decodable>(request: ATProtoHTTPRequest) async -> Result<ATProtoHTTPClientResponse, ATProtoHTTPClientError<ATProtoHTTPClientMethodError>> {
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: request.urlRequest)
            
            guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
                return .failure(.noResponse)
            }

            switch(httpURLResponse.statusCode) {
            case 200:
                do {
                    return .success(try JSONDecoder().decode(ATProtoHTTPClientResponse.self, from: data))
                } catch(let error) {
                    return .failure(.badResponse(error: error))
                }

            case 400:
                do {
                    let badRequestErrorResponse = try JSONDecoder().decode(ATProtoHTTPClientBadRequestErrorResponse<ATProtoHTTPClientMethodError>.self, from: data)

                    return .failure(.badRequest(error: badRequestErrorResponse.error, message: badRequestErrorResponse.message))
                } catch(let error) {
                    return .failure(.badResponse(error: error))
                }

            case 401:
                return .failure(.unauthorized)
                
            case 403:
                return .failure(.forbidden)
                
            case 404:
                return .failure(.notFound)
                
            case 413:
                return .failure(.largePayload)
                
            case 429:
                return .failure(.tooManyRequests)
                
            case 500:
                return .failure(.internalServerError)
                
            case 501:
                return .failure(.notImplemented)
                
            case 502, 503, 504:
                return .failure(.unavailable)
                
            default:
                return .failure(.unknown(status: httpURLResponse.statusCode))
            }
        } catch(let error) {
            return .failure(.session(error: error))
        }
    }
}
