//
//  APIClient.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import Foundation

class APIClient {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = endpoint.method
        request.timeoutInterval = APIConfig.timeout
                
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            do {
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError(error)
            }
            
        case 500...599:
            throw NetworkError.serverError
        default:
            throw NetworkError.httpError(httpResponse.statusCode)
        }
    }
}


extension APIClient {
    
    func fetchFixtures() async throws -> [Fixture] {
        try await request(Endpoint.fixtures)
    }
    
    func fetchMatchDetail(_ id: Int) async throws -> MatchResult {
        try await request(Endpoint.match(id))
    }
}
