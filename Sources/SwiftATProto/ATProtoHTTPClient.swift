//
//  ATProtoHTTPClient.swift
//  
//
//  Created by Christopher Head on 7/27/23.
//

import Foundation

public enum ATProtoHTTPClientError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case largePayload
    case tooManyRequests
    case internalServerError
    case notImplemented
    case unavailable
    case unknown
}

public class ATProtoHTTPClient {
    @available(iOS 13.0.0, *)
    
    public init(){}
    
    @available(iOS 13.0.0, *)
    public func make<Response: Decodable>(request: ATProtoHTTPRequest) async throws -> Result<Response, ATProtoHTTPClientError> {
        let (data, urlResponse) = try await URLSession.shared.data(for: request.urlRequest)

        let httpURLResponse = urlResponse as? HTTPURLResponse
        
        switch(httpURLResponse?.statusCode) {
        case 200:
            let decodedData = try JSONDecoder().decode(Response.self, from: data)
            
            return .success(decodedData)

        case 400:
            return .failure(.badRequest)

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
            return .failure(.unknown)
        }
    }
}
