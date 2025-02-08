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
    
    var homeTeam: TeamInfo? {
        teams.first
    }
    
    var awayTeam: TeamInfo? {
        teams.last
    }
    
    var title: String {
        guard let homeTeam, let awayTeam else { return "--" }
        return "\(homeTeam.team.club.abbr) vs \(awayTeam.team.club.abbr)"
    }
    
    var displayStatus: String {
        guard let homeTeam, let awayTeam else { return "--" }
        switch status {
        case .completed, .inProgress: return "\(homeTeam.score ?? 0) - \(awayTeam.score ?? 0)"
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
