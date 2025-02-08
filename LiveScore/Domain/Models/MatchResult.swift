//
//  MatchResult.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import Foundation

struct MatchResult: Codable {
    let teams: [TeamScore]
    let teamLists: [TeamList]
    let status: String
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
