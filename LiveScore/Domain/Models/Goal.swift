//
//  Goal.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import Foundation

struct Goal: Codable {
    let personId: Int
    let assistId: Int?
    let clock: Clock
    let phase: String
    let type: String
    let description: String
}

struct GoalTimeline: Identifiable {
    let id: Int
    let clock: String
    let scorer: String
    let isHomeTeam: Bool
}
