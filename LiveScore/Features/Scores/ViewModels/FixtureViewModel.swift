//
//  FixtureViewModel.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import SwiftUI

@MainActor
@Observable class FixtureViewModel {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient = .init()) {
        self.apiClient = apiClient
    }
    
    var isLoading: Bool = false
    var fixtures: [Fixture] = []
    
    func fetchScores() async throws {
        isLoading = true
        fixtures = try await apiClient.fetchFixtures()
        isLoading = false
    }
}
