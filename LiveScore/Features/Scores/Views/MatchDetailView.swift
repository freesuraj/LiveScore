//
//  MatchDetailView.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import SwiftUI

struct MatchDetailView: View {
    let score: Fixture
    
    var body: some View {
        VStack {
            Text(score.teams[0].team.shortName)
            Text(score.displayStatus)
            Text(score.teams[1].team.shortName)
        }
    }
}

