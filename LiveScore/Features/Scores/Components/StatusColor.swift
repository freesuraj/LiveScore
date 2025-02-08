//
//  StatusColor.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import SwiftUI

extension Status {
    var backgroundColor: Color {
        switch self {
        case .completed:
            return .blue
        case .inProgress:
            return .red
        case .upcoming:
            return .gray
        }
    }
    
    var textColor: Color {
        switch self {
        case .completed:
            return .white
        case .inProgress:
            return .white
        case .upcoming:
            return .black
        }
    }
}

