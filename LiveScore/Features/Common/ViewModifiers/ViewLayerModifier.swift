//
//  ViewLayerModifier.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import SwiftUI

struct ViewLayerModifier: ViewModifier {
    
    let cornerRadius: CGFloat
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content.background {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
        }
    }
}

extension View {
    func bordered(cornerRadius: CGFloat = 8, backgroundColor: Color = .white) -> some View {
        modifier(ViewLayerModifier(cornerRadius: cornerRadius, backgroundColor: backgroundColor))
    }
}
