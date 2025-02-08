//
//  TextStyleModifier.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import SwiftUI

enum ComponentType {
    case fixtureTeamName
    case fixtureScore(status: Status)
    case fixtureTime
    
    var color: Color {
        switch self {
        case .fixtureTeamName: return .black
        case .fixtureScore(let status): return status == .upcoming ? .black : .white
        case .fixtureTime: return .gray
        }
    }
    
    var font: Font {
        Font.system(size: 14, weight: .medium, design: .default)
    }
}

struct TextStyleModifier: ViewModifier {
    let componentType: ComponentType
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch componentType {
        case .fixtureScore( let status):
            content.foregroundColor(componentType.color)
                .font(componentType.font)
                .padding()
                .bordered(cornerRadius: 8, backgroundColor: status.backgroundColor)
        default:
                content.foregroundColor(componentType.color)
                    .font(componentType.font)
        }
    }
}

extension View {
    func textStyled(componentType: ComponentType) -> some View {
        modifier(TextStyleModifier(componentType: componentType))
    }
}
