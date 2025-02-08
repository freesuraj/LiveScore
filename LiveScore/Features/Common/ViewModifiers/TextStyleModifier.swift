//
//  TextStyleModifier.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import SwiftUI

struct TextStyleModifier: ViewModifier {
    let style: TextComponentStyle
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch style {
        case .fixtureScore( let status):
            content.foregroundColor(style.color)
                .font(style.font)
                .padding()
                .bordered(cornerRadius: 8, backgroundColor: status.backgroundColor)
        default:
                content.foregroundColor(style.color)
                    .font(style.font)
        }
    }
}

extension View {
    func textStyled(style: TextComponentStyle) -> some View {
        modifier(TextStyleModifier(style: style))
    }
}
