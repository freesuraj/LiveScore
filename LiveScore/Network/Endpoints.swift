//
//  Endpoints.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import Foundation

enum Endpoint {
    case fixtures
    case match(_ id: Int)
    case awayTeamadge(_ id: Int)
    
    
    var path: String {
        switch self {
        case .fixtures:
            return "/fixtures.json"
        case .match: // TODO: Use match specific endpoint.
            return "/match.json"
        case .awayTeamadge(id: let id):
            return "/teams/\(id).png"
        }
    }
    
    var method: String {
        "GET"
    }
    
    var url: URL? {
        URLComponents(string: APIConfig.baseURLString + path)?.url
    }
}
