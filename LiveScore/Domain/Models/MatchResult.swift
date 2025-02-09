//
//  MatchResult.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import Foundation

struct MatchResult: Codable {
    let teams: [TeamInfo]
    let teamLists: [TeamList]
    let status: Status
    let matchOfficials: [MatchOfficial]
    let kickoff: Kickoff
    let id: Int
    let halfTimeScore: Score
    let ground: Ground
    let events: [Event]
    let clock: Clock
    let attendance: Int
}

struct Formation: Codable {
    let label: String
    let players: [[Int]]
}

// MARK: - Match Official Models
struct MatchOfficial: Codable {
    let matchOfficialId: Int
    let role: String?
    let birth: [String: String]
    let name: PersonName
    let id: Int
}

// MARK: - Event Models
struct Event: Codable {
    let id: Int?
    let personId: Int?
    let teamId: Int?
    let assistId: Int?
    let clock: Clock
    let phase: String
    let type: String
    let description: String?
    let time: EventTime
    let score: Score
}

struct Clock: Codable {
    let secs: Int
    let label: String
    
    var formattedLabel: String {
        label.replacingOccurrences(of: "00", with: "")
    }
}

struct EventTime: Codable {
    let millis: Int64
    let label: String
}

// MARK: - Other Models
struct Kickoff: Codable {
    let completeness: Int
    let millis: Int64
    let label: String
    
    var kickOffTime: String {
        Date(timeIntervalSince1970: Double(millis)).formatAsHourMinute()
    }
    
    var kickOffDate: String {
        Date(timeIntervalSince1970: Double(millis)).formatAsFullDate()
    }
}

struct Score: Codable {
    let homeScore: Int
    let awayScore: Int
}

struct Ground: Codable {
    let name: String
    let city: String
    let source: String
    let id: Int
}


extension MatchResult {
    var homeTeam: TeamInfo? {
        teams.first
    }
    
    var awayTeam: TeamInfo? {
        teams.last
    }
    
    var displayStatus: String {
        guard let homeTeam, let awayTeam else { return "--" }
        switch status {
        case .completed, .inProgress: return "\(homeTeam.score ?? 0) - \(awayTeam.score ?? 0)"
        default: return kickoff.kickOffTime
        }
    }
    
    var displayableHalfTimeScore: String {
        "HT \(halfTimeScore.homeScore) - \(halfTimeScore.awayScore)"
    }
    
    var goalTimelines: [GoalTimeline] {
        let goalEvents = events.filter{ $0.type == "G" }
        var timelines: [GoalTimeline] = []
        for event in goalEvents {
            guard let eventId = event.id, let teamId = event.teamId, let playerId = event.personId, let playerName = teamLists.first(where: { $0.teamId == event.teamId })?.allPlayers.first(where: { $0.id == playerId })?.name.display else { break }
            timelines.append(.init(id: eventId, clock: event.clock.formattedLabel, scorer: playerName, isHomeTeam: teamId == homeTeam?.team.id))
        }
        
        return timelines
    }
    
    var mainReferee: String? {
        matchOfficials.filter { $0.role == "MAIN" }.first?.name.display
    }
    
    var matchInfo: String {
        var info: [String] = []
        info.append("Kick Off: \(kickoff.kickOffTime)")
        info.append("\(kickoff.kickOffDate)")
        info.append("\(ground.name), \(ground.city)")
        info.append("Attendance: \(attendance)")
        if let mainReferee {
            info.append("Referee: \(mainReferee)")
        }
        
        return info.joined(separator: "\n")
    }
}
