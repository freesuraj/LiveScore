//
//  ScoreCardView.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import SwiftUI

struct ScoreCardView: View {
    
    var fixture: Fixture
    @Binding var selected: Bool
    
    private func teamLogo(_ team: Team) -> some View {
        ResizableAsyncImageView(url: team.awayTeamadgeUrl, width: 20, height: 20, contentMode: .fit)
    }
    private func teamCard(_ team: Team, isHomeTeam: Bool) -> some View {
        HStack {
            if !isHomeTeam {
                teamLogo(team)
            }
            Text(team.name)
                .textStyled(style: .fixtureTeamName)
                .frame(maxWidth: .infinity, alignment: isHomeTeam ? .leading : .trailing)
                .layoutPriority(1)
            if isHomeTeam {
                teamLogo(team)
            }
        }
    }
    
    @ViewBuilder
    fileprivate func fixtureStatus(_ fixture: Fixture) -> some View {
        Text(fixture.displayStatus)
            .multilineTextAlignment(.center)
            .textStyled(style: .fixtureScore(status: fixture.status))
            .layoutPriority(2)
            .padding(.horizontal, 10)
    }
    
    var body: some View {
        if let homeTeam = fixture.homeTeam, let awayTeam = fixture.awayTeam {
            VStack {
                HStack {
                    teamCard(homeTeam.team, isHomeTeam: true)
                    fixtureStatus(fixture)
                    teamCard(awayTeam.team, isHomeTeam: false)
                }
                if fixture.status == .inProgress, let label = fixture.clock?.label {
                    Text(label)
                        .textStyled(style: .fixtureTime)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
            .background {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(selected ? Color.purple.opacity(0.2) : Color.white)
            }

        }
    }
}
