//
//  ViewControlColorTexto.swift
//  PINEDO
//
//  Created by Matías Correnti on 16/12/15.
//  Copyright © 2015 Correnti. All rights reserved.
//

import UIKit

class ViewControlColorTexto: UIViewController {
    
    @IBOutlet var verColorResult: UIImageView!
    @IBOutlet var setColorR: UISlider!
    @IBOutlet var setColorB: UISlider!
    @IBOutlet var setColorG: UISlider!
    
    @IBAction func getColorR(_ sender: UISlider) {
        let red = CGFloat(sender.value)
        sender.thumbTintColor = UIColor(
            red: red,
            green: 0.0,
            blue: 0.0,
            alpha: 1.0)
        displayColors()
    }
    
    @IBAction func getColorG(_ sender: UISlider) {
        let green = CGFloat(sender.value)
        sender.thumbTintColor = UIColor(
            red: 0.0,
            green: green,
            blue: 0.0,
            alpha: 1.0)
        displayColors()
    }
    
    @IBAction func getColorB(_ sender: UISlider) {
        let blue = CGFloat(sender.value)
        sender.thumbTintColor = UIColor(
            red: 0.0,
            green: 0.0,
            blue: blue,
            alpha: 1.0)
        displayColors()
    }
    
    var delegate : DestinationViewDelegado! = nil
    var toPassColTexto: UIColor! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        let myColor = toPassColTexto
        
        //        if  sender.selectedSegmentIndex == 0{
        //            myColor = mySampleColorLabel.backgroundColor!
        //        } else {
        //            myColor = mySampleColorLabel.textColor
        //        }
        
        //Actualizo el valor de los UISliders
        if (myColor?.getRed(&r, green: &g, blue: &b, alpha: &a))!{
            setColorR.setValue(Float(r), animated: true)
            setColorG.setValue(Float(g), animated: true)
            setColorB.setValue(Float(b), animated: true)
            
            //Actualizo el color de los UISliders
            setColorR.thumbTintColor = UIColor(
                red: r,
                green: 0.0,
                blue: 0.0,
                alpha: 1.0)
            setColorG.thumbTintColor = UIColor(
                red: 0.0,
                green: g,
                blue: 0.0,
                alpha: 1.0)
            setColorB.thumbTintColor = UIColor(
                red: 0.0,
                green: 0.0,
                blue: b,
                alpha: 1.0)
        }
        displayColors()
    }
    
    func displayColors(){
        let red = CGFloat(setColorR.value)
        let green = CGFloat(setColorG.value)
        let blue = CGFloat(setColorB.value)
        let color = UIColor(
            red: red,
            green: green,
            blue: blue,
            alpha: 1.0)
        delegate.setColorTexto(color) //Regreso el color
        
        verColorResult.image = getImageColor(CGRect(x: 0, y: 0, width: 300, height: 80), color: color)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getImageColor(_ frame: CGRect, color: UIColor) -> UIImage {
        let size = CGSize(width: frame.width, height: frame.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        dibujarCuadro(frame, otro: color)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func dibujarCuadro(_ frame: CGRect, otro: UIColor) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.33)
        shadow.shadowOffset = CGSize(width: 0.6, height: 0.6)
        shadow.shadowBlurRadius = 2
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath()
        rectanglePath.move(to: CGPoint(x: frame.minX + 0.06322 * frame.width, y: frame.minY + 0.05000 * frame.height))
        rectanglePath.addLine(to: CGPoint(x: frame.minX + 0.93678 * frame.width, y: frame.minY + 0.05000 * frame.height))
        rectanglePath.addCurve(to: CGPoint(x: frame.minX + 0.95825 * frame.width, y: frame.minY + 0.05327 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.94779 * frame.width, y: frame.minY + 0.05000 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.95329 * frame.width, y: frame.minY + 0.05000 * frame.height))
        rectanglePath.addLine(to: CGPoint(x: frame.minX + 0.95921 * frame.width, y: frame.minY + 0.05375 * frame.height))
        rectanglePath.addCurve(to: CGPoint(x: frame.minX + 0.97313 * frame.width, y: frame.minY + 0.08157 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.96568 * frame.width, y: frame.minY + 0.05845 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.97077 * frame.width, y: frame.minY + 0.06864 * frame.height))
        rectanglePath.addCurve(to: CGPoint(x: frame.minX + 0.97500 * frame.width, y: frame.minY + 0.12643 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.97500 * frame.width, y: frame.minY + 0.09342 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.97500 * frame.width, y: frame.minY + 0.10442 * frame.height))
        rectanglePath.addLine(to: CGPoint(x: frame.minX + 0.97500 * frame.width, y: frame.minY + 0.84857 * frame.height))
        rectanglePath.addCurve(to: CGPoint(x: frame.minX + 0.97336 * frame.width, y: frame.minY + 0.89150 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.97500 * frame.width, y: frame.minY + 0.87058 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.97500 * frame.width, y: frame.minY + 0.88158 * frame.height))
        rectanglePath.addLine(to: CGPoint(x: frame.minX + 0.97313 * frame.width, y: frame.minY + 0.89343 * frame.height))
        rectanglePath.addCurve(to: CGPoint(x: frame.minX + 0.95921 * frame.width, y: frame.minY + 0.92125 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.97077 * frame.width, y: frame.minY + 0.90636 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.96568 * frame.width, y: frame.minY + 0.91655 * frame.height))
        rectanglePath.addCurve(to: CGPoint(x: frame.minX + 0.93678 * frame.width, y: frame.minY + 0.92500 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.95329 * frame.width, y: frame.minY + 0.92500 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.94779 * frame.width, y: frame.minY + 0.92500 * frame.height))
        rectanglePath.addLine(to: CGPoint(x: frame.minX + 0.06322 * frame.width, y: frame.minY + 0.92500 * frame.height))
        rectanglePath.addCurve(to: CGPoint(x: frame.minX + 0.04175 * frame.width, y: frame.minY + 0.92173 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.05221 * frame.width, y: frame.minY + 0.92500 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.04671 * frame.width, y: frame.minY + 0.92500 * frame.height))
        rectanglePath.addLine(to: CGPoint(x: frame.minX + 0.04079 * frame.width, y: frame.minY + 0.92125 * frame.height))
        rectanglePath.addCurve(to: CGPoint(x: frame.minX + 0.02687 * frame.width, y: frame.minY + 0.89343 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.03432 * frame.width, y: frame.minY + 0.91655 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.02923 * frame.width, y: frame.minY + 0.90636 * frame.height))
        rectanglePath.addCurve(to: CGPoint(x: frame.minX + 0.02500 * frame.width, y: frame.minY + 0.84857 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.02500 * frame.width, y: frame.minY + 0.88158 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.02500 * frame.width, y: frame.minY + 0.87058 * frame.height))
        rectanglePath.addLine(to: CGPoint(x: frame.minX + 0.02500 * frame.width, y: frame.minY + 0.12643 * frame.height))
        rectanglePath.addCurve(to: CGPoint(x: frame.minX + 0.02664 * frame.width, y: frame.minY + 0.08350 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.02500 * frame.width, y: frame.minY + 0.10442 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.02500 * frame.width, y: frame.minY + 0.09342 * frame.height))
        rectanglePath.addLine(to: CGPoint(x: frame.minX + 0.02687 * frame.width, y: frame.minY + 0.08157 * frame.height))
        rectanglePath.addCurve(to: CGPoint(x: frame.minX + 0.04079 * frame.width, y: frame.minY + 0.05375 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.02923 * frame.width, y: frame.minY + 0.06864 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.03432 * frame.width, y: frame.minY + 0.05845 * frame.height))
        rectanglePath.addCurve(to: CGPoint(x: frame.minX + 0.06322 * frame.width, y: frame.minY + 0.05000 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.04671 * frame.width, y: frame.minY + 0.05000 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.05221 * frame.width, y: frame.minY + 0.05000 * frame.height))
        rectanglePath.close()
        context?.saveGState()
        context?.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        otro.setFill()
        rectanglePath.fill()
        context?.restoreGState()
    }
}
