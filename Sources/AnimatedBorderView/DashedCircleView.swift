//
//  DashedCircleView.swift
//
//
//  Created by Khoi Nguyen on 12/11/24.
//

import SwiftUI

public struct DashedCircleView<DashColor: ShapeStyle>: View {
    
    let lineWidth: CGFloat
    let dashCount: Int
    let radius: CGFloat
    let dashPhase: CGFloat
    let dashLength: CGFloat
    let duration: CGFloat
    let dashColor: DashColor
    @Binding var phaseAnimation: Bool
    
    init(
        lineWidth: CGFloat,
        dashCount: Int,
        radius: CGFloat,
        duration: CGFloat,
        dashColor: DashColor,
        phaseAnimation: Binding<Bool>
    ) {
        self.lineWidth = lineWidth
        self.dashCount = dashCount
        self.radius = radius
        self.duration = duration
        self.dashColor = dashColor
        self._phaseAnimation = phaseAnimation
        
        let perimeter = 2 * .pi * (radius - lineWidth)
        self.dashLength =  perimeter / (CGFloat(dashCount) * 4)
        self.dashPhase = dashLength * 2
    }
    
    public var body: some View {
        Circle()
            .strokeBorder(
                dashColor,
                style: StrokeStyle(
                    lineWidth: lineWidth,
                    dash: [dashLength],
                    dashPhase: phaseAnimation ? dashPhase : 0)
            )
            .animation(
                phaseAnimation
                ? Animation.linear(duration: duration)
                    .repeatForever(autoreverses: false)
                : Animation.interactiveSpring, value: phaseAnimation)
    }
}
