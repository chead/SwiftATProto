//
//  ATProtoHTTPClient.swift
//  
//
//  Created by Christopher Head on 7/27/23.
//

import Foundation

public enum ATProtoHTTPClientError: Error {
    case unknown
}

public class ATProtoHTTPClient {
    @available(iOS 13.0.0, *)
    
    public init(){}
    
    @available(iOS 13.0.0, *)
    public func make<Response: Decodable>(request: ATProtoHTTPRequest) async throws -> Result<Response, Error> {
        let (data, urlResponse) = try await URLSession.shared.data(for: request.urlRequest)

        let httpURLResponse = urlResponse as? HTTPURLResponse
        
        switch(httpURLResponse?.statusCode) {
        case 200:
            let decodedData = try JSONDecoder().decode(Response.self, from: data)
            
            return .success(decodedData)

        default:
            return .failure(ATProtoHTTPClientError.unknown)
        }
    }
}
