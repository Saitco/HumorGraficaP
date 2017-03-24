//
//  ViewControlColor.swift
//  PINEDO
//
//  Created by Matías Correnti on 16/12/15.
//  Copyright © 2015 Correnti. All rights reserved.
//

import UIKit

class ViewControlColor: UIViewController {
    
    @IBOutlet var SegmenSelect: UISegmentedControl!
    @IBOutlet var verColorResult: UIImageView!
    @IBOutlet var setColorR: UISlider!
    @IBOutlet var setColorG: UISlider!
    @IBOutlet var setColorB: UISlider!
    @IBOutlet var setValorA: UISlider!
    
    @IBAction func getSegmenSelect(_ sender: UISegmentedControl) {
        ActualizarValoresControles(sender.selectedSegmentIndex)
    }
    
    @IBAction func getColorR(_ sender: UISlider) {
        let red = CGFloat(sender.value)
        sender.thumbTintColor = UIColor(
            red: red,
            green: 0.0,
            blue: 0.0,
            alpha: 1.0)
        GuardarColor()
    }
    
    @IBAction func getColorG(_ sender: UISlider) {
        let green = CGFloat(sender.value)
        sender.thumbTintColor = UIColor(
            red: 0.0,
            green: green,
            blue: 0.0,
            alpha: 1.0)
        GuardarColor()
    }
    
    @IBAction func getColorB(_ sender: UISlider) {
        let blue = CGFloat(sender.value)
        sender.thumbTintColor = UIColor(
            red: 0.0,
            green: 0.0,
            blue: blue,
            alpha: 1.0)
        GuardarColor()
    }
    
    @IBAction func getValorA(_ sender: UISlider) {
//        let alpha = CGFloat(sender.value)
        sender.thumbTintColor = UIColor(
            red: 1.0,
            green: 1.0,
            blue: 1.0,
            alpha: 1.0)
        GuardarColor()
    }
    
    var delegate : DestinationViewDelegado! = nil
    var toPassColFondo: UIColor! = nil
    var toPassColTexto: UIColor! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Actualizo el valor de los UISliders
        ActualizarValoresControles(SegmenSelect.selectedSegmentIndex)
    }
    
    func ActualizarValoresControles(_ valor: Int) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        var myColor: UIColor! = nil
        
        switch valor {
        case 0:
            myColor = toPassColFondo
            break
        case 1:
            myColor = toPassColTexto
            break
        default:
            myColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
            break
        }
        
        if myColor == nil {
            myColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        }
        
        if myColor.getRed(&r, green: &g, blue: &b, alpha: &a){
            setColorR.setValue(Float(r), animated: true)
            setColorG.setValue(Float(g), animated: true)
            setColorB.setValue(Float(b), animated: true)
            setValorA.setValue(Float(a), animated: true)
            
            //Actualizo el color de los UISliders
            setColorR.thumbTintColor = UIColor(red: r, green: 0.0, blue: 0.0, alpha: 1.0)
            setColorG.thumbTintColor = UIColor(red: 0.0, green: g, blue: 0.0, alpha: 1.0)
            setColorB.thumbTintColor = UIColor(red: 0.0, green: 0.0, blue: b, alpha: 1.0)
            setValorA.thumbTintColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    func GuardarColor(){
        let red = CGFloat(setColorR.value)
        let green = CGFloat(setColorG.value)
        let blue = CGFloat(setColorB.value)
        let alpha = CGFloat(setValorA.value)
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
        switch SegmenSelect.selectedSegmentIndex {
        case 0:
            delegate.setColorFondo(color)
            break
        case 1:
            delegate.setColorTexto(color)
            break
        default:
            delegate.setColorFondo(color)
            delegate.setColorTexto(color)
            break
        }
    }
    
    func displayColors(_ color: UIColor){
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
    
    func dibujarCuadroConTexto(_ frame: CGRect, fondo: UIColor, otro: UIColor) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.33)
        shadow.shadowOffset = CGSize(width: 0.1, height: -0.1)
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
        fondo.setFill()
        rectanglePath.fill()
        context?.restoreGState()
        
        
        
        //// Text Drawing
        let textPath = UIBezierPath()
        textPath.move(to: CGPoint(x: frame.minX + 0.14848 * frame.width, y: frame.minY + 0.62500 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.14848 * frame.width, y: frame.minY + 0.35400 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.19572 * frame.width, y: frame.minY + 0.35400 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.23102 * frame.width, y: frame.minY + 0.37057 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.21220 * frame.width, y: frame.minY + 0.35400 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.22397 * frame.width, y: frame.minY + 0.35953 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.24159 * frame.width, y: frame.minY + 0.42596 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.23807 * frame.width, y: frame.minY + 0.38162 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.24159 * frame.width, y: frame.minY + 0.40009 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.22745 * frame.width, y: frame.minY + 0.49435 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.24159 * frame.width, y: frame.minY + 0.45526 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.23688 * frame.width, y: frame.minY + 0.47806 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.18785 * frame.width, y: frame.minY + 0.51880 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.21802 * frame.width, y: frame.minY + 0.51065 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.20482 * frame.width, y: frame.minY + 0.51880 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.17613 * frame.width, y: frame.minY + 0.51880 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.17613 * frame.width, y: frame.minY + 0.62500 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.14848 * frame.width, y: frame.minY + 0.62500 * frame.height))
        textPath.close()
        textPath.move(to: CGPoint(x: frame.minX + 0.17613 * frame.width, y: frame.minY + 0.48163 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.18163 * frame.width, y: frame.minY + 0.48163 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.20447 * frame.width, y: frame.minY + 0.46817 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.19127 * frame.width, y: frame.minY + 0.48163 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.19888 * frame.width, y: frame.minY + 0.47714 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.21284 * frame.width, y: frame.minY + 0.43164 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.21005 * frame.width, y: frame.minY + 0.45920 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.21284 * frame.width, y: frame.minY + 0.44702 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.18712 * frame.width, y: frame.minY + 0.39117 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.21284 * frame.width, y: frame.minY + 0.40466 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.20427 * frame.width, y: frame.minY + 0.39117 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.17613 * frame.width, y: frame.minY + 0.39117 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.17613 * frame.width, y: frame.minY + 0.48163 * frame.height))
        textPath.close()
        textPath.move(to: CGPoint(x: frame.minX + 0.26347 * frame.width, y: frame.minY + 0.62500 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.26347 * frame.width, y: frame.minY + 0.35400 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.29167 * frame.width, y: frame.minY + 0.35400 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.29167 * frame.width, y: frame.minY + 0.62500 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.26347 * frame.width, y: frame.minY + 0.62500 * frame.height))
        textPath.close()
        textPath.move(to: CGPoint(x: frame.minX + 0.32564 * frame.width, y: frame.minY + 0.62500 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.32564 * frame.width, y: frame.minY + 0.35400 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.35045 * frame.width, y: frame.minY + 0.35400 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.41325 * frame.width, y: frame.minY + 0.53912 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.41325 * frame.width, y: frame.minY + 0.35400 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.43587 * frame.width, y: frame.minY + 0.35400 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.43587 * frame.width, y: frame.minY + 0.62500 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.41060 * frame.width, y: frame.minY + 0.62500 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.34825 * frame.width, y: frame.minY + 0.43988 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.34825 * frame.width, y: frame.minY + 0.62500 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.32564 * frame.width, y: frame.minY + 0.62500 * frame.height))
        textPath.close()
        textPath.move(to: CGPoint(x: frame.minX + 0.46974 * frame.width, y: frame.minY + 0.62500 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.46974 * frame.width, y: frame.minY + 0.35400 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.55443 * frame.width, y: frame.minY + 0.35400 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.55443 * frame.width, y: frame.minY + 0.39117 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.49794 * frame.width, y: frame.minY + 0.39117 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.49794 * frame.width, y: frame.minY + 0.46680 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.54427 * frame.width, y: frame.minY + 0.46680 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.54427 * frame.width, y: frame.minY + 0.50305 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.49794 * frame.width, y: frame.minY + 0.50305 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.49794 * frame.width, y: frame.minY + 0.58655 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.55873 * frame.width, y: frame.minY + 0.58655 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.55873 * frame.width, y: frame.minY + 0.62500 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.46974 * frame.width, y: frame.minY + 0.62500 * frame.height))
        textPath.close()
        textPath.move(to: CGPoint(x: frame.minX + 0.58235 * frame.width, y: frame.minY + 0.62500 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.58235 * frame.width, y: frame.minY + 0.35400 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.64067 * frame.width, y: frame.minY + 0.35400 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.68892 * frame.width, y: frame.minY + 0.38742 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.66167 * frame.width, y: frame.minY + 0.35400 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.67775 * frame.width, y: frame.minY + 0.36514 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.70567 * frame.width, y: frame.minY + 0.48383 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.70009 * frame.width, y: frame.minY + 0.40970 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.70567 * frame.width, y: frame.minY + 0.44183 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.68791 * frame.width, y: frame.minY + 0.58792 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.70567 * frame.width, y: frame.minY + 0.52850 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.69975 * frame.width, y: frame.minY + 0.56320 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.63820 * frame.width, y: frame.minY + 0.62500 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.67607 * frame.width, y: frame.minY + 0.61264 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.65950 * frame.width, y: frame.minY + 0.62500 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.58235 * frame.width, y: frame.minY + 0.62500 * frame.height))
        textPath.close()
        textPath.move(to: CGPoint(x: frame.minX + 0.61055 * frame.width, y: frame.minY + 0.58655 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.63161 * frame.width, y: frame.minY + 0.58655 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.66479 * frame.width, y: frame.minY + 0.56192 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.64644 * frame.width, y: frame.minY + 0.58655 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.65750 * frame.width, y: frame.minY + 0.57834 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.67574 * frame.width, y: frame.minY + 0.48712 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.67209 * frame.width, y: frame.minY + 0.54550 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.67574 * frame.width, y: frame.minY + 0.52057 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.66695 * frame.width, y: frame.minY + 0.42249 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.67574 * frame.width, y: frame.minY + 0.46124 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.67281 * frame.width, y: frame.minY + 0.43970 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.65239 * frame.width, y: frame.minY + 0.39795 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.66292 * frame.width, y: frame.minY + 0.41064 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.65807 * frame.width, y: frame.minY + 0.40247 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.62758 * frame.width, y: frame.minY + 0.39117 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.64671 * frame.width, y: frame.minY + 0.39343 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.63844 * frame.width, y: frame.minY + 0.39117 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.61055 * frame.width, y: frame.minY + 0.39117 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.61055 * frame.width, y: frame.minY + 0.58655 * frame.height))
        textPath.close()
        textPath.move(to: CGPoint(x: frame.minX + 0.79045 * frame.width, y: frame.minY + 0.63177 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.74110 * frame.width, y: frame.minY + 0.59296 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.76988 * frame.width, y: frame.minY + 0.63177 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.75343 * frame.width, y: frame.minY + 0.61884 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.72261 * frame.width, y: frame.minY + 0.48950 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.72877 * frame.width, y: frame.minY + 0.56708 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.72261 * frame.width, y: frame.minY + 0.53259 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.74120 * frame.width, y: frame.minY + 0.38568 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.72261 * frame.width, y: frame.minY + 0.44592 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.72881 * frame.width, y: frame.minY + 0.41132 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.79137 * frame.width, y: frame.minY + 0.34723 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.75359 * frame.width, y: frame.minY + 0.36005 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.77031 * frame.width, y: frame.minY + 0.34723 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.84140 * frame.width, y: frame.minY + 0.38568 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.81230 * frame.width, y: frame.minY + 0.34723 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.82898 * frame.width, y: frame.minY + 0.36005 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.86003 * frame.width, y: frame.minY + 0.48895 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.85382 * frame.width, y: frame.minY + 0.41132 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.86003 * frame.width, y: frame.minY + 0.44574 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.84140 * frame.width, y: frame.minY + 0.59351 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.86003 * frame.width, y: frame.minY + 0.53314 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.85382 * frame.width, y: frame.minY + 0.56799 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.79045 * frame.width, y: frame.minY + 0.63177 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.82898 * frame.width, y: frame.minY + 0.61902 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.81200 * frame.width, y: frame.minY + 0.63177 * frame.height))
        textPath.close()
        textPath.move(to: CGPoint(x: frame.minX + 0.79082 * frame.width, y: frame.minY + 0.59442 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.81952 * frame.width, y: frame.minY + 0.56595 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.80290 * frame.width, y: frame.minY + 0.59442 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.81247 * frame.width, y: frame.minY + 0.58493 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.83009 * frame.width, y: frame.minY + 0.48877 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.82657 * frame.width, y: frame.minY + 0.54697 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.83009 * frame.width, y: frame.minY + 0.52124 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.81947 * frame.width, y: frame.minY + 0.41296 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.83009 * frame.width, y: frame.minY + 0.45728 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.82655 * frame.width, y: frame.minY + 0.43201 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.79137 * frame.width, y: frame.minY + 0.38440 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.81239 * frame.width, y: frame.minY + 0.39392 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.80302 * frame.width, y: frame.minY + 0.38440 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.76312 * frame.width, y: frame.minY + 0.41296 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.77959 * frame.width, y: frame.minY + 0.38440 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.77017 * frame.width, y: frame.minY + 0.39392 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.75255 * frame.width, y: frame.minY + 0.48932 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.75607 * frame.width, y: frame.minY + 0.43201 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.75255 * frame.width, y: frame.minY + 0.45746 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.76308 * frame.width, y: frame.minY + 0.56558 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.75255 * frame.width, y: frame.minY + 0.52094 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.75606 * frame.width, y: frame.minY + 0.54636 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.79082 * frame.width, y: frame.minY + 0.59442 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.77010 * frame.width, y: frame.minY + 0.58481 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.77934 * frame.width, y: frame.minY + 0.59442 * frame.height))
        textPath.close()
        otro.setFill()
        textPath.fill()
    }
}
