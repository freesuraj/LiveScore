//
//  NetworkError.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

enum NetworkError: Error {
    case httpError(Int)
    case decodingError(Error)
    case invalidURL
    case serverError
    case unknown(Error)
    case invalidResponse
    
    var description: String {
        switch self {
        case .httpError(let code):
            return "HTTP Error: \(code)"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .invalidURL:
            return "Invalid URL"
        case .serverError:
            return "Server error"
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response"
        }
    }
}
