//
//  LiveScoreTests.swift
//  LiveScoreTests
//
//  Created by Suraj Pathak on 7/2/2025.
//

import Testing
@testable import LiveScore

@MainActor
struct LiveScoreTests {
    
    init() {
        MockURLProtocol.requestHandler = { request in
            if request.url?.absoluteString.contains("fixtures") == true {
                return (nil, MockResponse.mockFixtureJsonString.data(using: .utf8))
            } else if request.url?.absoluteString.contains("match") == true {
                return (nil, MockResponse.mockDetailJsonString.data(using: .utf8))
            }
            return (nil, nil)
        }
    }
    
    @Test("fixtures are loaded properly")
    func loadFixtures() async throws {
        let viewModel = FixtureViewModel(apiClient: APIClient(session: MockNetwork.mockURLSession))
        try await viewModel.fetchScores()
        let fixtures = try #require(await viewModel.fixtures)
        #expect(fixtures.count == 2)
        #expect(fixtures[0].homeTeam?.team.name == "Newcastle United")
        #expect(fixtures[0].awayTeam?.team.name == "West Ham United")
        #expect(fixtures[0].status == .upcoming)
        
        #expect(fixtures[1].status == .completed)
        #expect(fixtures[1].displayStatus == "1 - 1")

    }
    
    @Test("details are loaded properly", arguments: [1])
    func loadDetail(id: Int) async throws {
        let viewModel = MatchDetailViewModel(matchId: id, apiClient: APIClient(session: MockNetwork.mockURLSession))
        try await viewModel.fetchDetail()
        let matchResult = viewModel.detail
        let totalGoalScored = try #require(await matchResult?.goalTimelines)
        #expect(totalGoalScored.count == 4)
        #expect(matchResult?.homeTeam?.team.club.abbr == "SOU")
        #expect(matchResult?.awayTeam?.team.club.abbr == "LIV")
        #expect(matchResult?.attendance == 31278)
        
    }
}
