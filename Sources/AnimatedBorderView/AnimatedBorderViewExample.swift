//
//  AnimatedBorderViewExample.swift
//
//
//  Created by Khoi Nguyen on 26/11/24.
//

import Foundation
import SwiftUI

struct AnimatedBorderViewExample: View {
    @State private var isCircleAnimating = false
    @State private var isRoundRectAnimating = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 0) {
                dashedCircle
                dashedRoundRect
            }
        }
    }
    
    @ViewBuilder
    private var dashedCircle: some View {
        Button(action: {
            isCircleAnimating.toggle()
        }, label: {
            Text(isCircleAnimating ? "Stop" : "Start")
                .font(.title2)
                .foregroundStyle(Color.white)
        })
        .frame(width: 200, height: 200)
        .overlay {
            GeometryReader(content: { geometry in
                DashedCircleView(
                    lineWidth: 4,
                    dashCount: 2,
                    radius: geometry.size.width,
                    duration: 1,
                    dashColor: LinearGradient(
                        gradient: Gradient(colors: [Color.cyan, Color.purple, Color.green]),
                        startPoint: .leading,
                        endPoint: .trailing),
                    phaseAnimation: $isCircleAnimating
                )
            })
        }
        .onAppear {
            isCircleAnimating = true
        }
        .background(Color.black.opacity(0.8))
        .clipShape(Circle())
        .shadow(color: .indigo.opacity(0.5), radius: 20, x: 0, y: 10)
        .padding()
    }
    
    @ViewBuilder
    private var dashedRoundRect: some View {
        Button(action: {
            isRoundRectAnimating.toggle()
        }, label: {
            Text(isRoundRectAnimating ? "Stop" : "Start")
                .font(.title2)
                .foregroundStyle(Color.white)
        })
        .frame(width: 200, height: 250)
        .overlay {
            GeometryReader(content: { geometry in
                DashedRoundRectView(
                    lineWidth: 3,
                    dashCount: 4,
                    size: geometry.size,
                    cornerRadius: 20,
                    duration: 2,
                    dashColor: LinearGradient(
                        gradient: Gradient(colors: [Color.cyan, Color.purple, Color.green]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    phaseAnimation: $isRoundRectAnimating
                )
            })
        }
        .onAppear {
            isRoundRectAnimating = true
        }
        .background(Color.black.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .indigo.opacity(0.5), radius: 20, x: 0, y: 10)
        .padding()
    }
}

#Preview {
    AnimatedBorderViewExample()
}
