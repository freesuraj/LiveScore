//
//  TextComponentStyle.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import SwiftUI

enum TextComponentStyle {
    case fixtureTeamName
    case fixtureScore(status: Status)
    case fixtureTime
    case detailScoreFull
    case detailScoreHalfTime
    case detailTeamName
    case detailInfo
    case goalClock
    case goalEvent
    case player
    
    var color: Color {
        switch self {
        case .fixtureTeamName: return .black
        case .fixtureScore(let status): return status == .upcoming ? .black : .white
        case .fixtureTime: return .gray
        case .detailInfo, .detailTeamName, .goalEvent, .goalClock, .player: return .black
        case .detailScoreFull, .detailScoreHalfTime: return .white
        }
    }
    
    var font: Font {
        switch self {
        case .fixtureTeamName, .fixtureTime, .fixtureScore, .detailInfo, .goalClock, .player: return .system(size: 12, weight: .light, design: .default)
        case .detailTeamName: return .system(size: 16, weight: .bold, design: .default)
        case .detailScoreFull: return .system(size: 16, weight: .medium, design: .default)
        case .detailScoreHalfTime, .goalEvent: return .system(size: 12, weight: .medium, design: .default)
        }
        
    }
}
