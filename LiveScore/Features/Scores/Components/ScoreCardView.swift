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
        ResizableAsyncImageView(url: team.teamBadgeUrl, width: 20, height: 20, contentMode: .fit)
    }
    private func teamCard(_ team: Team, isHomeTeam: Bool) -> some View {
        HStack {
            if !isHomeTeam {
                teamLogo(team)
            }
            Text(team.name)
                .textStyled(componentType: .fixtureTeamName)
                .frame(maxWidth: .infinity, alignment: isHomeTeam ? .leading : .trailing)
                .layoutPriority(1)
            if isHomeTeam {
                teamLogo(team)
            }
        }
    }
    
    @ViewBuilder
    var body: some View {
        if let teamA = fixture.teamA, let teamB = fixture.teamB {
            VStack {
                HStack {
                    teamCard(teamA.team, isHomeTeam: true)
                    Text(fixture.displayStatus)
                        .multilineTextAlignment(.center)
                        .textStyled(componentType: .fixtureScore(status: fixture.status))
                        .layoutPriority(2)
                        .padding(.horizontal, 10)
                    teamCard(teamB.team, isHomeTeam: false)
                }
                if fixture.status == .inProgress, let label = fixture.clock?.label {
                    Text(label)
                        .textStyled(componentType: .fixtureTime)
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
