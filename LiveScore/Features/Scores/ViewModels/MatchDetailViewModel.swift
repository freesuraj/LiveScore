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
    
    init(matchId: Int) {
        self.matchId = matchId
    }
    
    func fetchDetail() async throws {
        detail = try await APIClient().fetchMatchDetail(matchId)
    }
}
