//
//  APIConfig.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import Foundation

enum APIConfig {
    static let baseURLString = "https://pyates-twocircles.github.io/two-circles-tech-test"
    static let timeout: TimeInterval = 30
    
    static func teamLogoURL(teamId: Int) -> URL? {
        URL.init(string: "\(baseURLString)/images/\(teamId).png")
    }
}
