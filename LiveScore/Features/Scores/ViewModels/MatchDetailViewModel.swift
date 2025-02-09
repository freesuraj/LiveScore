//
//  MatchDetailViewModel.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import SwiftUI

@MainActor
@Observable class MatchDetailViewModel {
    
    var detail: MatchResult?
    
    private var matchId: Int
    
    private let apiClient: APIClient
    
    init(matchId: Int, apiClient: APIClient = .init()) {
        self.matchId = matchId
        self.apiClient = apiClient
    }
    
    func fetchDetail() async throws {
        detail = try await apiClient.fetchMatchDetail(matchId)
    }
}
