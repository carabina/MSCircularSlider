//
//  MSCircularTrig.swift
//
//  Created by Mohamed Shahawy on 27/09/17.
//  Copyright © 2017 Mohamed Shahawy. All rights reserved.
//

import UIKit

public class MSCircularTrig {
    
    //================================================================================
    // TRIG METHODS
    //================================================================================
    

    
    //================================================================================
    // DRAWING METHODS
    //================================================================================
    
    @discardableResult
    public class func drawFilledCircle(ctx: CGContext, center: CGPoint, radius: CGFloat) -> CGRect {
        let frame = CGRect(x: center.x - radius, y: center.y - radius, width: 2 * radius, height: 2 * radius)
        ctx.fillEllipse(in: frame)
        return frame
    }
    
    public class func drawUnfilledCircle(ctx: CGContext, center: CGPoint, radius: CGFloat, lineWidth: CGFloat, maximumAngle: CGFloat, lineCap: CGLineCap) {
        
        drawUnfilledArc(ctx: ctx, center: center, radius: radius, lineWidth: lineWidth, fromAngle: 0, toAngle: maximumAngle, lineCap: lineCap)
    }
    
    public class func drawUnfilledArc(ctx: CGContext, center: CGPoint, radius: CGFloat, lineWidth: CGFloat, fromAngle: CGFloat, toAngle: CGFloat, lineCap: CGLineCap) {
        let cartesianFromAngle = compassToCartesian(toRad(Double(fromAngle)))
        let cartesianToAngle = compassToCartesian(toRad(Double(toAngle)))
        
        ctx.addArc(center: center, radius: radius, startAngle: CGFloat(cartesianFromAngle), endAngle: CGFloat(cartesianToAngle), clockwise: false)
        
        ctx.setLineWidth(lineWidth)
        ctx.setLineCap(lineCap)
        ctx.drawPath(using: CGPathDrawingMode.stroke)
    }
    
    public class func drawUnfilledGradientArc(ctx: CGContext, center: CGPoint, radius: CGFloat, lineWidth: CGFloat, maximumAngle: CGFloat, colors: [UIColor], lineCap: CGLineCap) {
        
        let cartesianFromAngle = compassToCartesian(toRad(Double(0)))
        let cartesianToAngle = compassToCartesian(toRad(Double(maximumAngle)))
        
        ctx.saveGState()
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(cartesianFromAngle), endAngle: CGFloat(cartesianToAngle), clockwise: true)
        _ = path.cgPath.copy(strokingWithWidth: lineWidth, lineCap: lineCap, lineJoin: CGLineJoin.round, miterLimit: lineWidth)
        ctx.clip()
        
        let baseSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: baseSpace, colors: [colors[1].cgColor, colors[0].cgColor] as CFArray, locations: nil)
        let startPoint = CGPoint(x: center.x - radius, y: center.y + radius)
        let endPoint = CGPoint(x: center.x + radius, y: center.y - radius)
        ctx.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
        
        ctx.restoreGState()
    }
    

    
    
    //================================================================================
    // MATH UTILITIES METHODS
    //================================================================================
    
    
    
}



