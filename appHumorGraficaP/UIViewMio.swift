//
//  UIViewMio.swift
//  PINEDO
//
//  Created by Matías Correnti on 22/12/15.
//  Copyright © 2015 Correnti. All rights reserved.
//

import UIKit

@IBDesignable
class UIViewMio: UIView {
    
    
    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
        self.backgroundColor = UIColor(red: 0.992, green: 0.784, blue: 0.180, alpha: 1.000)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) //UIColor(red: 0.992, green: 0.784, blue: 0.180, alpha: 1.000)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //// General Declarations
//        let context = UIGraphicsGetCurrentContext()
        //// Color Declarations
        let colorG = UIColor(red: 0.832, green: 0.832, blue: 0.832, alpha: 1.000)
        
//        //// Symbol Drawing
//        let symbolRect = CGRectMake(27, 55, 327, 52)
//        CGContextSaveGState(context)
//        UIRectClip(symbolRect)
//        CGContextTranslateCTM(context, symbolRect.origin.x, symbolRect.origin.y)

        dibujar(rect, color: colorG)
//        CGContextRestoreGState(context)
        self.setNeedsDisplay()
    }
    
    
    func dibujar(_ frame: CGRect, color: UIColor) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let color4 = color.colorWithShadow(0.1)
        
        //// Shadow Declarations
        let shadow2 = NSShadow()
        shadow2.shadowColor = UIColor.black.withAlphaComponent(0.25)
        shadow2.shadowOffset = CGSize(width: 0.1, height: -0.1)
        shadow2.shadowBlurRadius = 2
        
        //// Linea Drawing
        let lineaPath = UIBezierPath()
        lineaPath.move(to: CGPoint(x: frame.minX + 0.38291 * frame.width, y: frame.minY + 3.7))
        lineaPath.addCurve(to: CGPoint(x: frame.minX + 0.49866 * frame.width, y: frame.minY + 2), controlPoint1: CGPoint(x: frame.minX + 0.38291 * frame.width, y: frame.minY + 3.7), controlPoint2: CGPoint(x: frame.minX + 0.49011 * frame.width, y: frame.minY + 2))
        lineaPath.addCurve(to: CGPoint(x: frame.minX + 0.61689 * frame.width, y: frame.minY + 3.7), controlPoint1: CGPoint(x: frame.minX + 0.50721 * frame.width, y: frame.minY + 2), controlPoint2: CGPoint(x: frame.minX + 0.61689 * frame.width, y: frame.minY + 3.7))
        lineaPath.addCurve(to: CGPoint(x: frame.minX + 0.61910 * frame.width, y: frame.minY + 3.92), controlPoint1: CGPoint(x: frame.minX + 0.61797 * frame.width, y: frame.minY + 3.75), controlPoint2: CGPoint(x: frame.minX + 0.61846 * frame.width, y: frame.minY + 3.79))
        lineaPath.addCurve(to: CGPoint(x: frame.minX + 0.61910 * frame.width, y: frame.minY + 4.88), controlPoint1: CGPoint(x: frame.minX + 0.61973 * frame.width, y: frame.minY + 4.05), controlPoint2: CGPoint(x: frame.minX + 0.61973 * frame.width, y: frame.minY + 4.73))
        lineaPath.addCurve(to: CGPoint(x: frame.minX + 0.61689 * frame.width, y: frame.minY + 5), controlPoint1: CGPoint(x: frame.minX + 0.61851 * frame.width, y: frame.minY + 5), controlPoint2: CGPoint(x: frame.minX + 0.61797 * frame.width, y: frame.minY + 5))
        lineaPath.addCurve(to: CGPoint(x: frame.minX + 0.49866 * frame.width, y: frame.minY + 3.2), controlPoint1: CGPoint(x: frame.minX + 0.61689 * frame.width, y: frame.minY + 5), controlPoint2: CGPoint(x: frame.minX + 0.50719 * frame.width, y: frame.minY + 3.2))
        lineaPath.addCurve(to: CGPoint(x: frame.minX + 0.38291 * frame.width, y: frame.minY + 5), controlPoint1: CGPoint(x: frame.minX + 0.49014 * frame.width, y: frame.minY + 3.2), controlPoint2: CGPoint(x: frame.minX + 0.38291 * frame.width, y: frame.minY + 5))
        lineaPath.addCurve(to: CGPoint(x: frame.minX + 0.38070 * frame.width, y: frame.minY + 4.88), controlPoint1: CGPoint(x: frame.minX + 0.38182 * frame.width, y: frame.minY + 5), controlPoint2: CGPoint(x: frame.minX + 0.38133 * frame.width, y: frame.minY + 5.03))
        lineaPath.addCurve(to: CGPoint(x: frame.minX + 0.38070 * frame.width, y: frame.minY + 3.92), controlPoint1: CGPoint(x: frame.minX + 0.38006 * frame.width, y: frame.minY + 4.73), controlPoint2: CGPoint(x: frame.minX + 0.38006 * frame.width, y: frame.minY + 4.07))
        lineaPath.addCurve(to: CGPoint(x: frame.minX + 0.38291 * frame.width, y: frame.minY + 3.7), controlPoint1: CGPoint(x: frame.minX + 0.38128 * frame.width, y: frame.minY + 3.8), controlPoint2: CGPoint(x: frame.minX + 0.38194 * frame.width, y: frame.minY + 3.75))
        lineaPath.close()
        lineaPath.lineCapStyle = CGLineCap.round
        
        lineaPath.lineJoinStyle = CGLineJoin.round
        
        color.setFill()
        lineaPath.fill()
        
        ////// Linea Inner Shadow
        context?.saveGState()
        context?.clip(to: lineaPath.bounds)
        context?.setShadow(offset: CGSize(width: 0, height: 0), blur: 0)
        context?.setAlpha(((shadow2.shadowColor as! UIColor).cgColor).alpha)
        context?.beginTransparencyLayer(auxiliaryInfo: nil)
        let lineaOpaqueShadow = (shadow2.shadowColor as! UIColor).withAlphaComponent(1)
        context?.setShadow(offset: shadow2.shadowOffset, blur: shadow2.shadowBlurRadius, color: lineaOpaqueShadow.cgColor)
        context?.setBlendMode(CGBlendMode.sourceOut)
        context?.beginTransparencyLayer(auxiliaryInfo: nil)
        
        lineaOpaqueShadow.setFill()
        lineaPath.fill()
        
        context?.endTransparencyLayer()
        context?.endTransparencyLayer()
        context?.restoreGState()
        
        color4.setStroke()
        lineaPath.lineWidth = 0.3
        lineaPath.stroke()
    }
}
