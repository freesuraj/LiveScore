//
//  Fixture.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import Foundation

struct Fixture: Codable, Identifiable {
    let kickoff: Kickoff
    let teams: [TeamInfo]
    let ground: Ground
    let status: Status
    let id: Int
    let attendance: Int?
    let clock: Clock?
    let goals: [Goal]?
    
    var teamA: TeamInfo? {
        teams.first
    }
    
    var teamB: TeamInfo? {
        teams.last
    }
    
    var displayStatus: String {
        guard let teamA, let teamB else { return "--" }
        switch status {
        case .completed, .inProgress: return "\(teamA.score ?? 0) : \(teamB.score ?? 0)"
        default: return kickoff.kickOffTime
        }
    }
}

enum Status: String, Codable {
    case completed = "C"
    case inProgress = "I"
    case upcoming = "U"
}


extension [Fixture] {
    
    func filteredBy(_ searchText: String) -> [Fixture] {
        guard !searchText.isEmpty else { return self }
        return self.filter { $0.teams.contains(where: { $0.team.name.localizedCaseInsensitiveContains(searchText)}) }
    }
}
