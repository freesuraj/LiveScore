//
//  ResizableAsyncImageView.swift
//  LiveScore
//
//  Created by Suraj Pathak on 8/2/2025.
//

import SwiftUI

struct ResizableAsyncImageView: View {
    
    let url: URL?
    let width: CGFloat
    let height: CGFloat
    let contentMode: ContentMode
    
    @ViewBuilder
    var body : some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(width: width, height: height)
            default:
                EmptyView()
            }
        }
            
    }
}
