//
//  Team.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import Foundation

struct TeamInfo: Codable {
    let team: Team
    let score: Int?
}

struct Team: Codable {
    let name: String
    let club: Club
    let teamType: String
    let shortName: String
    let id: Int
}

struct Club: Codable {
    let name: String
    let abbr: String
    let id: Int
}


// MARK: - Team List Models
struct TeamList: Codable {
    let teamId: Int
    let lineup: [Player]
    let substitutes: [Player]
    let formation: Formation
    
    var allPlayers: [Player] {
        lineup + substitutes
    }
}

struct Player: Codable {
    let matchPosition: String
    let matchShirtNumber: Int
    let captain: Bool
    let playerId: Int
    let info: PlayerInfo
    let nationalTeam: NationalTeam
    let birth: Birth
    let age: String
    let name: PersonName
    let id: Int
}

struct PlayerInfo: Codable {
    let position: String
    let shirtNum: Int
    let positionInfo: String
    let loan: Bool?
}

struct NationalTeam: Codable {
    let isoCode: String
    let country: String
    let demonym: String?
}

struct Birth: Codable {
    let date: BirthDate
    let country: NationalTeam?
    let place: String?
}

struct BirthDate: Codable {
    let millis: Int64
    let label: String
}

struct PersonName: Codable {
    let display: String
    let first: String
    let middle: String?
    let last: String
}


extension Team {
    var awayTeamadgeUrl: URL? {
        APIConfig.teamLogoURL(teamId: id)
    }
}
