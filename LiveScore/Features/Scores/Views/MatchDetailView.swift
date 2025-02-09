//
//  MatchDetailView.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import SwiftUI

struct MatchDetailView: View {
    
    @State private var viewModel: MatchDetailViewModel
    @State private var title: String = ""
    @State private var loadingError: Error?
    @State private var timer: Timer?
    
    init(_ fixture: Fixture) {
        title = fixture.title
        viewModel = .init(matchId: fixture.id)
    }
    
    private func teamLogo(_ team: Team) -> some View {
        ResizableAsyncImageView(url: team.teamBadgeUrl, width: 40, height: 40, contentMode: .fit)
    }
    
    private func clubCard(_ team: Team, isHomeTeam: Bool) -> some View {
        HStack {
            if isHomeTeam {
                teamLogo(team)
            }
            Text(team.club.abbr)
                .textStyled(style: .detailTeamName)
                .frame(maxWidth: .infinity, alignment: isHomeTeam ? .leading : .trailing)
                .layoutPriority(1)
            if !isHomeTeam {
                teamLogo(team)
            }
        }
    }
    
    fileprivate func goalStatus(_ result: MatchResult) -> some View {
        VStack() {
            Text(result.displayStatus)
                .textStyled(style: .detailScoreFull)
            Spacer()
            Text(result.displayableHalfTimeScore)
                .textStyled(style: .detailScoreHalfTime)
        }
        .padding()
        .bordered(cornerRadius: 8, backgroundColor: result.status.backgroundColor)
        .layoutPriority(2)
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder
    private func teamAndScoreCard(_ result: MatchResult) -> some View {
        if let homeTeam = result.homeTeam, let awayTeam = result.awayTeam {
            HStack {
                clubCard(homeTeam.team, isHomeTeam: true)
                goalStatus(result)
                clubCard(awayTeam.team, isHomeTeam: false)
            }
        }
    }
    
    private func matchInfo(_ result: MatchResult) -> some View {
        Text(result.matchInfo)
            .textStyled(style: .detailInfo)
            .multilineTextAlignment(.center)
    }
    
    private func goalTimeline(_ result: MatchResult) -> some View {
        VStack(spacing: 2) {
            ForEach(result.goalTimelines) { timeline in
                HStack(spacing: 0) {
                    if timeline.isHomeTeam {
                        goalLine(timeline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("")
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("")
                            .frame(maxWidth: .infinity)
                        goalLine(timeline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
    }
    
    private func goalLine(_ timeline: GoalTimeline) -> some View {
        HStack {
            Text(timeline.clock)
                .textStyled(style: .goalClock)
            Text("Goal")
                .textStyled(style: .goalEvent)
            Text(timeline.scorer)
                .textStyled(style: .player)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                if let errorMessage = loadingError?.localizedDescription {
                    ErrorView(message: errorMessage) {
                        loadingError = nil
                        Task {
                            await fetchDetail()
                        }
                    }
                }  else if let matchResult = viewModel.detail {
                    teamAndScoreCard(matchResult)
                    Spacer()
                    goalTimeline(matchResult)
                    Divider()
                    matchInfo(matchResult)
                }
            }
            .padding()
            .bordered(cornerRadius: 8)
            .padding(.horizontal)
        }
        .background(Color.gray.opacity(0.2))
        .navigationTitle(title)
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
        
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
            Task { await fetchDetail() }
        }
        
        // First time, start fetching
        Task { await fetchDetail() }
        
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func fetchDetail() async {
        do {
            try await viewModel.fetchDetail()
        } catch {
            loadingError = error
        }
    }
}

