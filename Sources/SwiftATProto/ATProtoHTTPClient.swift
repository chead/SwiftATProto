//
//  ATProtoHTTPClient.swift
//  
//
//  Created by Christopher Head on 7/27/23.
//

import Foundation

public enum ATProtoHTTPClientError<RequestError: Decodable>: Error {
    case badRequest(error: RequestError?)
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

public class ATProtoHTTPClient {
    @available(iOS 13.0.0, *)
    public static func make<Response: Decodable, RequestError: Decodable>(request: ATProtoHTTPRequest) async -> Result<Response, ATProtoHTTPClientError<RequestError>> {
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: request.urlRequest)
            
            guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
                return .failure(.noResponse)
            }

            switch(httpURLResponse.statusCode) {
            case 200:
                do {
                    return .success(try JSONDecoder().decode(Response.self, from: data))
                } catch(let error) {
                    return .failure(.badResponse(error: error))
                }

            case 400:
                return .failure(.badRequest(error: try? JSONDecoder().decode(RequestError.self, from: data)))

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
