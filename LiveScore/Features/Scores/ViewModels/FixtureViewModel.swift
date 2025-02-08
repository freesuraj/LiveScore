//
//  FixtureViewModel.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import SwiftUI

@MainActor
@Observable class FixtureViewModel {
    var isLoading: Bool = false
    var fixtures: [Fixture] = []
    
    func fetchScores() async throws {
        isLoading = true
        fixtures = try await APIClient().fetchFixtures()
        isLoading = false
    }
}
