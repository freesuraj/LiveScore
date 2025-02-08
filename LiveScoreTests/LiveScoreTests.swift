//
//  LiveScoreTests.swift
//  LiveScoreTests
//
//  Created by Suraj Pathak on 7/2/2025.
//

import Testing
@testable import LiveScore

struct LiveScoreTests {
    
    @Test("fixtures are loaded properly")
    func loadFixtures() async throws {
        let viewModel = await FixtureViewModel()
        try await viewModel.fetchScores()
        let fixtures = try #require(await viewModel.fixtures)
        #expect(fixtures.count == 5)
    }
    
    @Test("details are loaded properly", arguments: [1])
    func loadDetail(id: Int) async throws {
        let viewModel = await MatchDetailViewModel(matchId: id)
        try await viewModel.fetchDetail()
        let totalGoalScored = try #require(await viewModel.detail?.goalTimelines)
        #expect(totalGoalScored.count == 4)
    }
}
