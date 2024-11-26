//
//  DashedRoundRectView.swift
//
//
//  Created by Khoi Nguyen on 12/11/24.
//

import SwiftUI

public struct DashedRoundRectView<DashColor: ShapeStyle>: View {
    let lineWidth: CGFloat
    let dashCount: Int
    let size: CGSize
    let cornerRadius: CGFloat
    let duration: CGFloat
    let dashColor: DashColor
    let dashPhase: CGFloat
    let dashLength: CGFloat
    
    @Binding var phaseAnimation: Bool
    
    init(
        lineWidth: CGFloat,
        dashCount: Int,
        size: CGSize,
        cornerRadius: CGFloat,
        duration: CGFloat,
        dashColor: DashColor,
        phaseAnimation: Binding<Bool>
    ) {
        self.lineWidth = lineWidth
        self.dashCount = dashCount
        self.size = size
        self.cornerRadius = cornerRadius
        self.duration = duration
        self.dashColor = dashColor
        self._phaseAnimation = phaseAnimation
        
        let perimeter = 2 * (size.width + size.height)
        - (lineWidth * 4) // subtracted to remove the overlaps at the corners.
        - (8 * cornerRadius) // subtracted to remove the lenght of rounded corner part
        + (2 * .pi * cornerRadius) // added 4 rounded corder which is a whole circle
        
        self.dashLength = perimeter / CGFloat(dashCount * 2)
        self.dashPhase = dashLength * 2.0
    }
    
    public var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .strokeBorder(
                dashColor,
                style: StrokeStyle(
                    lineWidth: lineWidth,
                    lineCap: .round,
                    lineJoin: .round,
                    dash: [dashLength],
                    dashPhase: phaseAnimation ? dashPhase : 0))
            .animation(
                phaseAnimation
                ? Animation.linear(duration: duration)
                    .repeatForever(autoreverses: false)
                : Animation.default, value: phaseAnimation)
    }
}
