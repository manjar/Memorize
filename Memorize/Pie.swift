//
//  Pie.swift
//  Memorize
//
//  Created by Eli Manjarrez on 10/27/20.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            return AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle(radians: newValue.first)
            endAngle   = Angle(radians: newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.size.width, rect.size.height) / 2.0
        let start  = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        
        var returnPath = Path()
        returnPath.move(to: center)
        returnPath.addLine(to: start)
        returnPath.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise)
        returnPath.addLine(to: center)
        return returnPath
    }
}
