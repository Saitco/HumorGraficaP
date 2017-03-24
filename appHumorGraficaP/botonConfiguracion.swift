//
//  botonConfiguracion.swift
//  PINEDO
//
//  Created by Matías Correnti on 17/12/15.
//  Copyright © 2015 Correnti. All rights reserved.
//


extension UIColor {
    func colorWithHue(_ newHue: CGFloat) -> UIColor {
        var saturation: CGFloat = 1.0, brightness: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getHue(nil, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: newHue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    func colorWithSaturation(_ newSaturation: CGFloat) -> UIColor {
        var hue: CGFloat = 1.0, brightness: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getHue(&hue, saturation: nil, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: hue, saturation: newSaturation, brightness: brightness, alpha: alpha)
    }
    func colorWithBrightness(_ newBrightness: CGFloat) -> UIColor {
        var hue: CGFloat = 1.0, saturation: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getHue(&hue, saturation: &saturation, brightness: nil, alpha: &alpha)
        return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
    }
    func colorWithAlpha(_ newAlpha: CGFloat) -> UIColor {
        var hue: CGFloat = 1.0, saturation: CGFloat = 1.0, brightness: CGFloat = 1.0
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: newAlpha)
    }
    func colorWithHighlight(_ highlight: CGFloat) -> UIColor {
        var red: CGFloat = 1.0, green: CGFloat = 1.0, blue: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red * (1-highlight) + highlight, green: green * (1-highlight) + highlight, blue: blue * (1-highlight) + highlight, alpha: alpha * (1-highlight) + highlight)
    }
    func colorWithShadow(_ shadow: CGFloat) -> UIColor {
        var red: CGFloat = 1.0, green: CGFloat = 1.0, blue: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red * (1-shadow), green: green * (1-shadow), blue: blue * (1-shadow), alpha: alpha * (1-shadow) + shadow)
    }
}

//  MODO DE USO
//var color = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)
//var color2 = UIColor(hex:0xFFFFFF)
//var color3 = UIColor(hex:"FFFFFF")!
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(hexInt:Int) {
        self.init(red:(hexInt >> 16) & 0xff, green:(hexInt >> 8) & 0xff, blue:hexInt & 0xff)
    }
    convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        if hexString.hasPrefix("#") {
            let start = hexString.characters.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.characters.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}

enum Botones {
    case diseño_A
    case diseño_B
    case diseño_C
}

import UIKit

@IBDesignable
class botonConfiguracion: UIButton {
    
    
    
    fileprivate struct Cache {
        static var colorApple: UIColor = UIColor(red: 0.082, green: 0.494, blue: 0.984, alpha: 1.000)
        static var colorPinedo: UIColor = UIColor(red: 0.992, green: 0.784, blue: 0.180, alpha: 1.000)
    }
    
    
    internal class var colorPinedo: UIColor { return Cache.colorPinedo }
    internal class var colorApple: UIColor { return Cache.colorApple }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.showsTouchWhenHighlighted = true
        self.autoresizesSubviews = true
        
        let context = UIGraphicsGetCurrentContext()
        let symbol2Rect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        context?.saveGState()
        UIRectClip(symbol2Rect)
        context?.translateBy(x: symbol2Rect.origin.x, y: symbol2Rect.origin.y)
        context?.scaleBy(x: symbol2Rect.size.width / 100, y: symbol2Rect.size.height / 100)
        
        if Diseño == .diseño_A {
            dibujarConfiguracion(Color, valor: girar/100, rotacionON: rotacion, ocultarCentro: centro, ocultarDientesEX: dientesEX, ocultarDientesIN: dientesIN)
        } else if Diseño == .diseño_B {
            dibujarConfiguracion2(Color, valor: girar/100, rotacionON: rotacion, ocultarCentro: centro, ocultarDientesEX: dientesEX, ocultarDientesIN: dientesIN)
        } else if Diseño == .diseño_C {
            dibujarConfiguracion3(Color, valor: girar/100, rotacionON: rotacion, ocultarCentro: centro, ocultarDientesEX: dientesEX, ocultarDientesIN: dientesIN)
        }
        
        context?.restoreGState()
    }
    
    @IBInspectable
    var Diseño: Botones = Botones.diseño_A {
        didSet {
            actualizarPropiedades()
        }
    }
 
    @IBInspectable
    var girar: CGFloat = 0 {
        didSet {
            actualizarPropiedades()
        }
    }
    
    @IBInspectable
    var rotacion: Bool = true {
        didSet {
            actualizarPropiedades()
        }
    }
    
    @IBInspectable
    var centro: Bool = true {
        didSet {
            actualizarPropiedades()
        }
    }
    
    @IBInspectable
    var dientesEX: Bool = true {
        didSet {
            actualizarPropiedades()
        }
    }
    
    @IBInspectable
    var dientesIN: Bool = true {
        didSet {
            actualizarPropiedades()
        }
    }
    
    @IBInspectable
    var Color: UIColor = botonConfiguracion.colorApple {
        didSet {
            actualizarPropiedades()
        }
    }
    
//    var esPinedo: Bool = false {
//        didSet {
//            return self.esPinedo ? favorite() : notFavorite()
//        }
//    }
    
    fileprivate func actualizarPropiedades()
    {
        super.setNeedsDisplay()//Le dice al sistema que hay que volver a dibujar el control (drawRect)
        super.layer.displayIfNeeded() //Que necesita mostrar
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        actualizarPropiedades()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func getImagenBoton() -> UIImage {
        var imagen = UIImage()
        if Diseño == Botones.diseño_A {
            imagen = getImagenControl(Color, valor: girar)
        } else if Diseño == Botones.diseño_B {
            imagen = getImagenControl2(Color, valor: girar)
        } else if Diseño == Botones.diseño_C {
            imagen = getImagenControl3(Color, valor: girar)
        }
        return imagen
    }
    
//    func getImagenControl(valor: CGFloat) -> UIImage {
//        return getImagenControl(Cache.colorApple, valor: valor)
//    }
//    
//    func getImagenControl2(valor: CGFloat) -> UIImage {
//        return getImagenControl2(Cache.colorApple, valor: valor)
//    }
//    
//    func getImagenControl3(valor: CGFloat) -> UIImage {
//        return getImagenControl3(Cache.colorApple, valor: valor)
//    }
//    
    func getImagenControl(_ color: UIColor, valor: CGFloat) -> UIImage {
        let size = CGSize(width: 100, height: 100)
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Symbol 2 Drawing
        let symbol2Rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        context?.saveGState()
        UIRectClip(symbol2Rect)
        context?.translateBy(x: symbol2Rect.origin.x, y: symbol2Rect.origin.y)
        context?.scaleBy(x: symbol2Rect.size.width / 100, y: symbol2Rect.size.height / 100)
        
        dibujarConfiguracion(color, valor: valor/100, rotacionON: rotacion, ocultarCentro: centro, ocultarDientesEX: dientesEX, ocultarDientesIN: dientesIN)
        
        context?.restoreGState()
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func getImagenControl2(_ color: UIColor, valor: CGFloat) -> UIImage {
        let size = CGSize(width: 100, height: 100)
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Symbol 2 Drawing
        let symbol2Rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        context?.saveGState()
        UIRectClip(symbol2Rect)
        context?.translateBy(x: symbol2Rect.origin.x, y: symbol2Rect.origin.y)
        context?.scaleBy(x: symbol2Rect.size.width / 100, y: symbol2Rect.size.height / 100)
        
        dibujarConfiguracion2(color, valor: valor/100, rotacionON: rotacion, ocultarCentro: centro, ocultarDientesEX: dientesEX, ocultarDientesIN: dientesIN)
        
        context?.restoreGState()
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func getImagenControl3(_ color: UIColor, valor: CGFloat) -> UIImage {
        let size = CGSize(width: 100, height: 100)
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Symbol 2 Drawing
        let symbol2Rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        context?.saveGState()
        UIRectClip(symbol2Rect)
        context?.translateBy(x: symbol2Rect.origin.x, y: symbol2Rect.origin.y)
        context?.scaleBy(x: symbol2Rect.size.width / 100, y: symbol2Rect.size.height / 100)
        
        dibujarConfiguracion3(color, valor: valor/100, rotacionON: rotacion, ocultarCentro: centro, ocultarDientesEX: dientesEX, ocultarDientesIN: dientesIN)
        
        context?.restoreGState()
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    
    func dibujarConfiguracion(_ color: UIColor, valor: CGFloat, rotacionON: Bool, ocultarCentro: Bool, ocultarDientesEX: Bool, ocultarDientesIN: Bool) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let color4 = color.colorWithShadow(0.1)
        
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.33)
        shadow.shadowOffset = CGSize(width: 0.1, height: -0.1)
        shadow.shadowBlurRadius = 2
        let shadow2 = NSShadow()
        shadow2.shadowColor = UIColor.black.withAlphaComponent(0.25)
        shadow2.shadowOffset = CGSize(width: 0.1, height: -0.1)
        shadow2.shadowBlurRadius = 2
        let shadow3 = NSShadow()
        shadow3.shadowColor = UIColor.black.withAlphaComponent(0.25)
        shadow3.shadowOffset = CGSize(width: 0.1, height: -0.1)
        shadow3.shadowBlurRadius = 6
        
        //// Variable Declarations
        let sizeCentro2: CGFloat = valor / 2.0 + 1
        let sizeDientes3: CGFloat = (sizeCentro2 + 3) / 4.0
        let rotacionDientes: CGFloat = rotacionON == true ? valor / 2.0 * 150 : 0
        let rotacionDientes2: CGFloat = rotacionON == true ? (valor + 0.28 / 2.0) * 75 : 10.5
        
        if (ocultarDientesEX) {
            //// DientesExternos Drawing
            context?.saveGState()
            context?.translateBy(x: 50, y: 50)
            context?.rotate(by: -rotacionDientes * CGFloat(M_PI) / 180)
            
            let dientesExternosPath = UIBezierPath()
            dientesExternosPath.move(to: CGPoint(x: 11.07, y: -46.8))
            dientesExternosPath.addCurve(to: CGPoint(x: 10.61, y: -30.67), controlPoint1: CGPoint(x: 10.89, y: -40.44), controlPoint2: CGPoint(x: 10.71, y: -34.07))
            dientesExternosPath.addCurve(to: CGPoint(x: 0.55, y: -32.44), controlPoint1: CGPoint(x: 7.45, y: -31.76), controlPoint2: CGPoint(x: 4.07, y: -32.38))
            dientesExternosPath.addCurve(to: CGPoint(x: 5.71, y: -47.75), controlPoint1: CGPoint(x: 1.63, y: -35.65), controlPoint2: CGPoint(x: 3.67, y: -41.71))
            dientesExternosPath.addCurve(to: CGPoint(x: 11.07, y: -46.8), controlPoint1: CGPoint(x: 7.44, y: -47.48), controlPoint2: CGPoint(x: 9.32, y: -47.12))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: -1.07, y: -32.43))
            dientesExternosPath.addCurve(to: CGPoint(x: -11.11, y: -30.49), controlPoint1: CGPoint(x: -4.59, y: -32.31), controlPoint2: CGPoint(x: -7.96, y: -31.64))
            dientesExternosPath.addCurve(to: CGPoint(x: -11.8, y: -46.67), controlPoint1: CGPoint(x: -11.25, y: -33.89), controlPoint2: CGPoint(x: -11.53, y: -40.29))
            dientesExternosPath.addCurve(to: CGPoint(x: -6.46, y: -47.67), controlPoint1: CGPoint(x: -10.36, y: -46.94), controlPoint2: CGPoint(x: -6.46, y: -47.67))
            dientesExternosPath.addCurve(to: CGPoint(x: -1.07, y: -32.43), controlPoint1: CGPoint(x: -6.46, y: -47.67), controlPoint2: CGPoint(x: -2.2, y: -35.63))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 27.1, y: -39.62))
            dientesExternosPath.addCurve(to: CGPoint(x: 20.89, y: -24.8), controlPoint1: CGPoint(x: 24.66, y: -33.8), controlPoint2: CGPoint(x: 22.22, y: -27.96))
            dientesExternosPath.addCurve(to: CGPoint(x: 12.16, y: -30.08), controlPoint1: CGPoint(x: 18.3, y: -27), controlPoint2: CGPoint(x: 15.35, y: -28.79))
            dientesExternosPath.addCurve(to: CGPoint(x: 22.48, y: -42.49), controlPoint1: CGPoint(x: 14.34, y: -32.71), controlPoint2: CGPoint(x: 18.41, y: -37.61))
            dientesExternosPath.addCurve(to: CGPoint(x: 27.1, y: -39.62), controlPoint1: CGPoint(x: 23.96, y: -41.57), controlPoint2: CGPoint(x: 25.59, y: -40.56))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: -12.63, y: -29.89))
            dientesExternosPath.addCurve(to: CGPoint(x: -21.29, y: -24.46), controlPoint1: CGPoint(x: -15.81, y: -28.54), controlPoint2: CGPoint(x: -18.73, y: -26.7))
            dientesExternosPath.addCurve(to: CGPoint(x: -27.75, y: -39.26), controlPoint1: CGPoint(x: -22.66, y: -27.59), controlPoint2: CGPoint(x: -25.21, y: -33.44))
            dientesExternosPath.addCurve(to: CGPoint(x: -23.12, y: -42.13), controlPoint1: CGPoint(x: -26.27, y: -40.18), controlPoint2: CGPoint(x: -24.63, y: -41.19))
            dientesExternosPath.addCurve(to: CGPoint(x: -12.63, y: -29.89), controlPoint1: CGPoint(x: -18.99, y: -37.31), controlPoint2: CGPoint(x: -14.84, y: -32.47))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 39.47, y: -27.11))
            dientesExternosPath.addCurve(to: CGPoint(x: 28.41, y: -15.62), controlPoint1: CGPoint(x: 35.14, y: -22.61), controlPoint2: CGPoint(x: 30.8, y: -18.09))
            dientesExternosPath.addCurve(to: CGPoint(x: 22.16, y: -23.68), controlPoint1: CGPoint(x: 26.76, y: -18.63), controlPoint2: CGPoint(x: 24.65, y: -21.34))
            dientesExternosPath.addCurve(to: CGPoint(x: 36.19, y: -31.47), controlPoint1: CGPoint(x: 25.15, y: -25.34), controlPoint2: CGPoint(x: 30.68, y: -28.41))
            dientesExternosPath.addCurve(to: CGPoint(x: 39.47, y: -27.11), controlPoint1: CGPoint(x: 37.24, y: -30.07), controlPoint2: CGPoint(x: 38.4, y: -28.54))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: -22.52, y: -23.33))
            dientesExternosPath.addCurve(to: CGPoint(x: -28.66, y: -15.17), controlPoint1: CGPoint(x: -24.97, y: -20.96), controlPoint2: CGPoint(x: -27.05, y: -18.21))
            dientesExternosPath.addCurve(to: CGPoint(x: -39.94, y: -26.56), controlPoint1: CGPoint(x: -31.07, y: -17.6), controlPoint2: CGPoint(x: -35.52, y: -22.09))
            dientesExternosPath.addCurve(to: CGPoint(x: -36.66, y: -30.92), controlPoint1: CGPoint(x: -38.89, y: -27.96), controlPoint2: CGPoint(x: -37.74, y: -29.5))
            dientesExternosPath.addCurve(to: CGPoint(x: -22.52, y: -23.33), controlPoint1: CGPoint(x: -31.1, y: -27.94), controlPoint2: CGPoint(x: -25.52, y: -24.94))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 46.5, y: -10.96))
            dientesExternosPath.addCurve(to: CGPoint(x: 32.12, y: -4.28), controlPoint1: CGPoint(x: 40.88, y: -8.35), controlPoint2: CGPoint(x: 35.25, y: -5.74))
            dientesExternosPath.addCurve(to: CGPoint(x: 29.22, y: -14.05), controlPoint1: CGPoint(x: 31.67, y: -7.74), controlPoint2: CGPoint(x: 30.67, y: -11.03))
            dientesExternosPath.addCurve(to: CGPoint(x: 45.01, y: -16.21), controlPoint1: CGPoint(x: 32.63, y: -14.52), controlPoint2: CGPoint(x: 38.83, y: -15.37))
            dientesExternosPath.addCurve(to: CGPoint(x: 46.5, y: -10.96), controlPoint1: CGPoint(x: 45.49, y: -14.53), controlPoint2: CGPoint(x: 46.01, y: -12.68))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: -29.42, y: -13.62))
            dientesExternosPath.addCurve(to: CGPoint(x: -32.19, y: -3.79), controlPoint1: CGPoint(x: -30.83, y: -10.57), controlPoint2: CGPoint(x: -31.78, y: -7.27))
            dientesExternosPath.addCurve(to: CGPoint(x: -46.75, y: -10.3), controlPoint1: CGPoint(x: -35.33, y: -5.2), controlPoint2: CGPoint(x: -41.05, y: -7.76))
            dientesExternosPath.addCurve(to: CGPoint(x: -45.26, y: -15.56), controlPoint1: CGPoint(x: -46.27, y: -11.98), controlPoint2: CGPoint(x: -45.75, y: -13.84))
            dientesExternosPath.addCurve(to: CGPoint(x: -29.42, y: -13.62), controlPoint1: CGPoint(x: -39.05, y: -14.8), controlPoint2: CGPoint(x: -32.82, y: -14.03))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 47.75, y: 1.21))
            dientesExternosPath.addCurve(to: CGPoint(x: 47.25, y: 6.65), controlPoint1: CGPoint(x: 47.59, y: 2.95), controlPoint2: CGPoint(x: 47.41, y: 4.87))
            dientesExternosPath.addCurve(to: CGPoint(x: 31.49, y: 7.66), controlPoint1: CGPoint(x: 41.1, y: 7.04), controlPoint2: CGPoint(x: 34.93, y: 7.44))
            dientesExternosPath.addCurve(to: CGPoint(x: 32.4, y: -0.02), controlPoint1: CGPoint(x: 32.08, y: 5.19), controlPoint2: CGPoint(x: 32.4, y: 2.62))
            dientesExternosPath.addCurve(to: CGPoint(x: 32.31, y: -2.49), controlPoint1: CGPoint(x: 32.4, y: -0.85), controlPoint2: CGPoint(x: 32.37, y: -1.67))
            dientesExternosPath.addCurve(to: CGPoint(x: 47.75, y: 1.21), controlPoint1: CGPoint(x: 35.67, y: -1.68), controlPoint2: CGPoint(x: 41.72, y: -0.23))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: -31.37, y: 8.11))
            dientesExternosPath.addCurve(to: CGPoint(x: -47.25, y: 7.33), controlPoint1: CGPoint(x: -31.37, y: 8.11), controlPoint2: CGPoint(x: -41.04, y: 7.64))
            dientesExternosPath.addCurve(to: CGPoint(x: -47.75, y: 1.89), controlPoint1: CGPoint(x: -47.41, y: 5.59), controlPoint2: CGPoint(x: -47.59, y: 3.67))
            dientesExternosPath.addCurve(to: CGPoint(x: -32.34, y: -2.03), controlPoint1: CGPoint(x: -41.72, y: 0.35), controlPoint2: CGPoint(x: -35.67, y: -1.19))
            dientesExternosPath.addCurve(to: CGPoint(x: -31.37, y: 8.11), controlPoint1: CGPoint(x: -33, y: 4), controlPoint2: CGPoint(x: -31.37, y: 8.11))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 44.03, y: 18.45))
            dientesExternosPath.addCurve(to: CGPoint(x: 41.61, y: 23.34), controlPoint1: CGPoint(x: 43.26, y: 20.01), controlPoint2: CGPoint(x: 42.4, y: 21.74))
            dientesExternosPath.addCurve(to: CGPoint(x: 26.55, y: 18.56), controlPoint1: CGPoint(x: 35.73, y: 21.48), controlPoint2: CGPoint(x: 29.84, y: 19.61))
            dientesExternosPath.addCurve(to: CGPoint(x: 31, y: 9.43), controlPoint1: CGPoint(x: 28.48, y: 15.8), controlPoint2: CGPoint(x: 30, y: 12.73))
            dientesExternosPath.addCurve(to: CGPoint(x: 44.03, y: 18.45), controlPoint1: CGPoint(x: 33.85, y: 11.4), controlPoint2: CGPoint(x: 38.95, y: 14.93))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: -26.29, y: 18.93))
            dientesExternosPath.addCurve(to: CGPoint(x: -41.37, y: 23.95), controlPoint1: CGPoint(x: -29.57, y: 20.02), controlPoint2: CGPoint(x: -35.48, y: 21.99))
            dientesExternosPath.addCurve(to: CGPoint(x: -43.79, y: 19.06), controlPoint1: CGPoint(x: -42.14, y: 22.39), controlPoint2: CGPoint(x: -43, y: 20.66))
            dientesExternosPath.addCurve(to: CGPoint(x: -30.87, y: 9.84), controlPoint1: CGPoint(x: -38.74, y: 15.46), controlPoint2: CGPoint(x: -33.68, y: 11.84))
            dientesExternosPath.addCurve(to: CGPoint(x: -26.29, y: 18.93), controlPoint1: CGPoint(x: -29.83, y: 13.13), controlPoint2: CGPoint(x: -28.27, y: 16.19))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 3.03, y: 47.75))
            dientesExternosPath.addLine(to: CGPoint(x: -2.41, y: 47.75))
            dientesExternosPath.addCurve(to: CGPoint(x: -4.87, y: 32.03), controlPoint1: CGPoint(x: -3.37, y: 41.6), controlPoint2: CGPoint(x: -4.34, y: 35.44))
            dientesExternosPath.addCurve(to: CGPoint(x: 5.27, y: 31.97), controlPoint1: CGPoint(x: -3.28, y: 32.27), controlPoint2: CGPoint(x: 3.55, y: 32.25))
            dientesExternosPath.addCurve(to: CGPoint(x: 3.03, y: 47.75), controlPoint1: CGPoint(x: 4.78, y: 35.4), controlPoint2: CGPoint(x: 3.9, y: 41.59))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 34.37, y: 33.18))
            dientesExternosPath.addCurve(to: CGPoint(x: 30.35, y: 36.86), controlPoint1: CGPoint(x: 33.08, y: 34.36), controlPoint2: CGPoint(x: 31.66, y: 35.65))
            dientesExternosPath.addCurve(to: CGPoint(x: 18.01, y: 26.93), controlPoint1: CGPoint(x: 25.53, y: 32.98), controlPoint2: CGPoint(x: 20.7, y: 29.1))
            dientesExternosPath.addCurve(to: CGPoint(x: 25.46, y: 20.03), controlPoint1: CGPoint(x: 20.84, y: 25.03), controlPoint2: CGPoint(x: 23.35, y: 22.7))
            dientesExternosPath.addCurve(to: CGPoint(x: 34.37, y: 33.18), controlPoint1: CGPoint(x: 27.4, y: 22.91), controlPoint2: CGPoint(x: 30.89, y: 28.05))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: -17.65, y: 27.16))
            dientesExternosPath.addCurve(to: CGPoint(x: -29.91, y: 37.32), controlPoint1: CGPoint(x: -20.31, y: 29.37), controlPoint2: CGPoint(x: -25.12, y: 33.35))
            dientesExternosPath.addCurve(to: CGPoint(x: -33.93, y: 33.64), controlPoint1: CGPoint(x: -31.19, y: 36.14), controlPoint2: CGPoint(x: -32.61, y: 34.84))
            dientesExternosPath.addCurve(to: CGPoint(x: -25.2, y: 20.36), controlPoint1: CGPoint(x: -30.52, y: 28.45), controlPoint2: CGPoint(x: -27.09, y: 23.24))
            dientesExternosPath.addCurve(to: CGPoint(x: -17.65, y: 27.16), controlPoint1: CGPoint(x: -23.06, y: 23), controlPoint2: CGPoint(x: -20.51, y: 25.3))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 20.05, y: 43.41))
            dientesExternosPath.addCurve(to: CGPoint(x: 14.98, y: 45.38), controlPoint1: CGPoint(x: 18.43, y: 44.04), controlPoint2: CGPoint(x: 16.64, y: 44.73))
            dientesExternosPath.addCurve(to: CGPoint(x: 7.04, y: 31.63), controlPoint1: CGPoint(x: 11.88, y: 40.01), controlPoint2: CGPoint(x: 8.77, y: 34.62))
            dientesExternosPath.addCurve(to: CGPoint(x: 16.47, y: 27.9), controlPoint1: CGPoint(x: 10.41, y: 30.88), controlPoint2: CGPoint(x: 13.58, y: 29.61))
            dientesExternosPath.addCurve(to: CGPoint(x: 20.05, y: 43.41), controlPoint1: CGPoint(x: 17.25, y: 31.28), controlPoint2: CGPoint(x: 18.66, y: 37.35))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: -6.64, y: 31.71))
            dientesExternosPath.addCurve(to: CGPoint(x: -14.41, y: 45.63), controlPoint1: CGPoint(x: -8.33, y: 34.73), controlPoint2: CGPoint(x: -11.37, y: 40.19))
            dientesExternosPath.addCurve(to: CGPoint(x: -19.48, y: 43.65), controlPoint1: CGPoint(x: -16.03, y: 44.99), controlPoint2: CGPoint(x: -17.82, y: 44.3))
            dientesExternosPath.addCurve(to: CGPoint(x: -16.12, y: 28.1), controlPoint1: CGPoint(x: -18.17, y: 37.57), controlPoint2: CGPoint(x: -16.85, y: 31.48))
            dientesExternosPath.addCurve(to: CGPoint(x: -6.64, y: 31.71), controlPoint1: CGPoint(x: -13.22, y: 29.77), controlPoint2: CGPoint(x: -10.02, y: 31.01))
            dientesExternosPath.close()
            dientesExternosPath.lineCapStyle = CGLineCap.round
            
            dientesExternosPath.lineJoinStyle = CGLineJoin.round
            
            context?.saveGState()
            context?.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            color.setFill()
            dientesExternosPath.fill()
            
            ////// DientesExternos Inner Shadow
            context?.saveGState()
            context?.clip(to: dientesExternosPath.bounds)
            context?.setShadow(offset: CGSize(width: 0, height: 0), blur: 0)
            context?.setAlpha(((shadow2.shadowColor as! UIColor).cgColor).alpha)
            context?.beginTransparencyLayer(auxiliaryInfo: nil)
            let dientesExternosOpaqueShadow = (shadow2.shadowColor as! UIColor).withAlphaComponent(1)
            context?.setShadow(offset: shadow2.shadowOffset, blur: shadow2.shadowBlurRadius, color: dientesExternosOpaqueShadow.cgColor)
            context?.setBlendMode(CGBlendMode.sourceOut)
            context?.beginTransparencyLayer(auxiliaryInfo: nil)
            
            dientesExternosOpaqueShadow.setFill()
            dientesExternosPath.fill()
            
            context?.endTransparencyLayer()
            context?.endTransparencyLayer()
            context?.restoreGState()
            
            context?.restoreGState()
            
            color4.setStroke()
            dientesExternosPath.lineWidth = 0.2
            dientesExternosPath.stroke()
            
            context?.restoreGState()
        }
        
        
        if (ocultarDientesIN) {
            //// DientesInternos Drawing
            context?.saveGState()
            context?.translateBy(x: 50, y: 50)
            context?.rotate(by: -rotacionDientes2 * CGFloat(M_PI) / 180)
            context?.scaleBy(x: sizeDientes3, y: sizeDientes3)
            
            let dientesInternosPath = UIBezierPath()
            dientesInternosPath.move(to: CGPoint(x: 3.26, y: -27.15))
            dientesInternosPath.addCurve(to: CGPoint(x: 1.34, y: -21.46), controlPoint1: CGPoint(x: 2.58, y: -25.15), controlPoint2: CGPoint(x: 1.9, y: -23.15))
            dientesInternosPath.addCurve(to: CGPoint(x: -1.68, y: -21.44), controlPoint1: CGPoint(x: 0.37, y: -21.45), controlPoint2: CGPoint(x: -0.72, y: -21.44))
            dientesInternosPath.addCurve(to: CGPoint(x: -3.67, y: -27.08), controlPoint1: CGPoint(x: -2.27, y: -23.11), controlPoint2: CGPoint(x: -2.97, y: -25.1))
            dientesInternosPath.addCurve(to: CGPoint(x: -4.14, y: -26.99), controlPoint1: CGPoint(x: -3.83, y: -27.05), controlPoint2: CGPoint(x: -3.99, y: -27.02))
            dientesInternosPath.addCurve(to: CGPoint(x: -6.71, y: -26.51), controlPoint1: CGPoint(x: -5, y: -26.83), controlPoint2: CGPoint(x: -5.89, y: -26.66))
            dientesInternosPath.addCurve(to: CGPoint(x: -6.45, y: -20.51), controlPoint1: CGPoint(x: -6.62, y: -24.4), controlPoint2: CGPoint(x: -6.53, y: -22.29))
            dientesInternosPath.addCurve(to: CGPoint(x: -9.26, y: -19.4), controlPoint1: CGPoint(x: -7.34, y: -20.16), controlPoint2: CGPoint(x: -8.37, y: -19.75))
            dientesInternosPath.addCurve(to: CGPoint(x: -13.15, y: -23.93), controlPoint1: CGPoint(x: -10.41, y: -20.74), controlPoint2: CGPoint(x: -11.78, y: -22.34))
            dientesInternosPath.addCurve(to: CGPoint(x: -15.78, y: -22.3), controlPoint1: CGPoint(x: -14.01, y: -23.4), controlPoint2: CGPoint(x: -14.93, y: -22.82))
            dientesInternosPath.addCurve(to: CGPoint(x: -13.39, y: -16.83), controlPoint1: CGPoint(x: -14.94, y: -20.38), controlPoint2: CGPoint(x: -14.1, y: -18.45))
            dientesInternosPath.addCurve(to: CGPoint(x: -15.63, y: -14.76), controlPoint1: CGPoint(x: -14.1, y: -16.18), controlPoint2: CGPoint(x: -14.91, y: -15.42))
            dientesInternosPath.addCurve(to: CGPoint(x: -20.85, y: -17.56), controlPoint1: CGPoint(x: -17.18, y: -15.59), controlPoint2: CGPoint(x: -19.01, y: -16.58))
            dientesInternosPath.addCurve(to: CGPoint(x: -22.71, y: -15.08), controlPoint1: CGPoint(x: -21.46, y: -16.75), controlPoint2: CGPoint(x: -22.12, y: -15.88))
            dientesInternosPath.addCurve(to: CGPoint(x: -18.55, y: -10.88), controlPoint1: CGPoint(x: -21.25, y: -13.61), controlPoint2: CGPoint(x: -19.79, y: -12.13))
            dientesInternosPath.addCurve(to: CGPoint(x: -19.91, y: -8.11), controlPoint1: CGPoint(x: -18.98, y: -10.01), controlPoint2: CGPoint(x: -19.47, y: -9))
            dientesInternosPath.addCurve(to: CGPoint(x: -25.74, y: -8.83), controlPoint1: CGPoint(x: -21.64, y: -8.33), controlPoint2: CGPoint(x: -23.69, y: -8.58))
            dientesInternosPath.addCurve(to: CGPoint(x: -26.58, y: -5.84), controlPoint1: CGPoint(x: -26.01, y: -7.85), controlPoint2: CGPoint(x: -26.31, y: -6.8))
            dientesInternosPath.addCurve(to: CGPoint(x: -21.23, y: -3.45), controlPoint1: CGPoint(x: -24.71, y: -5), controlPoint2: CGPoint(x: -22.83, y: -4.16))
            dientesInternosPath.addCurve(to: CGPoint(x: -21.49, y: -0.35), controlPoint1: CGPoint(x: -21.31, y: -2.47), controlPoint2: CGPoint(x: -21.41, y: -1.34))
            dientesInternosPath.addCurve(to: CGPoint(x: -27.15, y: 1.09), controlPoint1: CGPoint(x: -23.18, y: 0.08), controlPoint2: CGPoint(x: -25.17, y: 0.58))
            dientesInternosPath.addCurve(to: CGPoint(x: -26.87, y: 4.18), controlPoint1: CGPoint(x: -27.06, y: 2.1), controlPoint2: CGPoint(x: -26.96, y: 3.19))
            dientesInternosPath.addCurve(to: CGPoint(x: -21.04, y: 4.47), controlPoint1: CGPoint(x: -24.82, y: 4.28), controlPoint2: CGPoint(x: -22.78, y: 4.38))
            dientesInternosPath.addCurve(to: CGPoint(x: -20.16, y: 7.47), controlPoint1: CGPoint(x: -20.76, y: 5.41), controlPoint2: CGPoint(x: -20.44, y: 6.51))
            dientesInternosPath.addCurve(to: CGPoint(x: -24.9, y: 10.85), controlPoint1: CGPoint(x: -21.58, y: 8.48), controlPoint2: CGPoint(x: -23.24, y: 9.66))
            dientesInternosPath.addCurve(to: CGPoint(x: -23.52, y: 13.63), controlPoint1: CGPoint(x: -24.45, y: 11.76), controlPoint2: CGPoint(x: -23.96, y: 12.74))
            dientesInternosPath.addCurve(to: CGPoint(x: -17.99, y: 11.78), controlPoint1: CGPoint(x: -21.59, y: 12.98), controlPoint2: CGPoint(x: -19.64, y: 12.33))
            dientesInternosPath.addCurve(to: CGPoint(x: -16.09, y: 14.26), controlPoint1: CGPoint(x: -17.39, y: 12.57), controlPoint2: CGPoint(x: -16.69, y: 13.47))
            dientesInternosPath.addCurve(to: CGPoint(x: -19.29, y: 19.13), controlPoint1: CGPoint(x: -17.05, y: 15.72), controlPoint2: CGPoint(x: -18.17, y: 17.43))
            dientesInternosPath.addCurve(to: CGPoint(x: -17.01, y: 21.22), controlPoint1: CGPoint(x: -18.54, y: 19.82), controlPoint2: CGPoint(x: -17.74, y: 20.55))
            dientesInternosPath.addCurve(to: CGPoint(x: -12.51, y: 17.49), controlPoint1: CGPoint(x: -15.43, y: 19.92), controlPoint2: CGPoint(x: -13.85, y: 18.61))
            dientesInternosPath.addCurve(to: CGPoint(x: -9.84, y: 19.12), controlPoint1: CGPoint(x: -11.66, y: 18.01), controlPoint2: CGPoint(x: -10.69, y: 18.6))
            dientesInternosPath.addCurve(to: CGPoint(x: -11.08, y: 24.82), controlPoint1: CGPoint(x: -10.21, y: 20.82), controlPoint2: CGPoint(x: -10.65, y: 22.82))
            dientesInternosPath.addCurve(to: CGPoint(x: -8.19, y: 25.94), controlPoint1: CGPoint(x: -10.13, y: 25.19), controlPoint2: CGPoint(x: -9.12, y: 25.59))
            dientesInternosPath.addCurve(to: CGPoint(x: -5.34, y: 20.83), controlPoint1: CGPoint(x: -7.19, y: 24.15), controlPoint2: CGPoint(x: -6.19, y: 22.36))
            dientesInternosPath.addCurve(to: CGPoint(x: -2.28, y: 21.38), controlPoint1: CGPoint(x: -4.37, y: 21.01), controlPoint2: CGPoint(x: -3.25, y: 21.21))
            dientesInternosPath.addCurve(to: CGPoint(x: -1.37, y: 27.15), controlPoint1: CGPoint(x: -2.01, y: 23.1), controlPoint2: CGPoint(x: -1.69, y: 25.13))
            dientesInternosPath.addLine(to: CGPoint(x: 1.72, y: 27.15))
            dientesInternosPath.addCurve(to: CGPoint(x: 2.55, y: 21.35), controlPoint1: CGPoint(x: 2.01, y: 25.12), controlPoint2: CGPoint(x: 2.3, y: 23.09))
            dientesInternosPath.addCurve(to: CGPoint(x: 5.6, y: 20.76), controlPoint1: CGPoint(x: 3.51, y: 21.17), controlPoint2: CGPoint(x: 4.63, y: 20.95))
            dientesInternosPath.addCurve(to: CGPoint(x: 8.52, y: 25.8), controlPoint1: CGPoint(x: 6.47, y: 22.27), controlPoint2: CGPoint(x: 7.5, y: 24.04))
            dientesInternosPath.addCurve(to: CGPoint(x: 11.4, y: 24.68), controlPoint1: CGPoint(x: 9.46, y: 25.44), controlPoint2: CGPoint(x: 10.48, y: 25.04))
            dientesInternosPath.addCurve(to: CGPoint(x: 10.09, y: 18.99), controlPoint1: CGPoint(x: 10.94, y: 22.69), controlPoint2: CGPoint(x: 10.48, y: 20.69))
            dientesInternosPath.addCurve(to: CGPoint(x: 12.74, y: 17.33), controlPoint1: CGPoint(x: 10.93, y: 18.46), controlPoint2: CGPoint(x: 11.89, y: 17.85))
            dientesInternosPath.addCurve(to: CGPoint(x: 17.26, y: 20.96), controlPoint1: CGPoint(x: 14.09, y: 18.41), controlPoint2: CGPoint(x: 15.67, y: 19.69))
            dientesInternosPath.addCurve(to: CGPoint(x: 19.54, y: 18.87), controlPoint1: CGPoint(x: 18, y: 20.28), controlPoint2: CGPoint(x: 18.81, y: 19.54))
            dientesInternosPath.addCurve(to: CGPoint(x: 16.28, y: 14.05), controlPoint1: CGPoint(x: 18.4, y: 17.18), controlPoint2: CGPoint(x: 17.25, y: 15.49))
            dientesInternosPath.addCurve(to: CGPoint(x: 18.15, y: 11.53), controlPoint1: CGPoint(x: 16.87, y: 13.25), controlPoint2: CGPoint(x: 17.56, y: 12.33))
            dientesInternosPath.addCurve(to: CGPoint(x: 23.66, y: 13.28), controlPoint1: CGPoint(x: 19.8, y: 12.05), controlPoint2: CGPoint(x: 21.73, y: 12.67))
            dientesInternosPath.addCurve(to: CGPoint(x: 25.04, y: 10.5), controlPoint1: CGPoint(x: 24.11, y: 12.37), controlPoint2: CGPoint(x: 24.6, y: 11.39))
            dientesInternosPath.addCurve(to: CGPoint(x: 20.26, y: 7.19), controlPoint1: CGPoint(x: 23.37, y: 9.34), controlPoint2: CGPoint(x: 21.69, y: 8.18))
            dientesInternosPath.addCurve(to: CGPoint(x: 21.1, y: 4.16), controlPoint1: CGPoint(x: 20.53, y: 6.23), controlPoint2: CGPoint(x: 20.84, y: 5.12))
            dientesInternosPath.addCurve(to: CGPoint(x: 26.87, y: 3.79), controlPoint1: CGPoint(x: 22.83, y: 4.05), controlPoint2: CGPoint(x: 24.85, y: 3.92))
            dientesInternosPath.addCurve(to: CGPoint(x: 27.15, y: 0.7), controlPoint1: CGPoint(x: 26.96, y: 2.78), controlPoint2: CGPoint(x: 27.06, y: 1.69))
            dientesInternosPath.addCurve(to: CGPoint(x: 21.49, y: -0.65), controlPoint1: CGPoint(x: 25.17, y: 0.23), controlPoint2: CGPoint(x: 23.18, y: -0.25))
            dientesInternosPath.addCurve(to: CGPoint(x: 21.18, y: -3.77), controlPoint1: CGPoint(x: 21.39, y: -1.65), controlPoint2: CGPoint(x: 21.27, y: -2.79))
            dientesInternosPath.addCurve(to: CGPoint(x: 26.44, y: -6.21), controlPoint1: CGPoint(x: 22.75, y: -4.5), controlPoint2: CGPoint(x: 24.6, y: -5.36))
            dientesInternosPath.addCurve(to: CGPoint(x: 25.59, y: -9.2), controlPoint1: CGPoint(x: 26.16, y: -7.19), controlPoint2: CGPoint(x: 25.87, y: -8.25))
            dientesInternosPath.addCurve(to: CGPoint(x: 19.78, y: -8.4), controlPoint1: CGPoint(x: 23.56, y: -8.92), controlPoint2: CGPoint(x: 21.52, y: -8.64))
            dientesInternosPath.addCurve(to: CGPoint(x: 18.38, y: -11.17), controlPoint1: CGPoint(x: 19.33, y: -9.29), controlPoint2: CGPoint(x: 18.82, y: -10.3))
            dientesInternosPath.addCurve(to: CGPoint(x: 22.44, y: -15.39), controlPoint1: CGPoint(x: 19.59, y: -12.43), controlPoint2: CGPoint(x: 21.02, y: -13.91))
            dientesInternosPath.addCurve(to: CGPoint(x: 20.58, y: -17.87), controlPoint1: CGPoint(x: 21.83, y: -16.2), controlPoint2: CGPoint(x: 21.18, y: -17.08))
            dientesInternosPath.addCurve(to: CGPoint(x: 15.4, y: -15), controlPoint1: CGPoint(x: 18.76, y: -16.86), controlPoint2: CGPoint(x: 16.94, y: -15.85))
            dientesInternosPath.addCurve(to: CGPoint(x: 13.12, y: -17.04), controlPoint1: CGPoint(x: 14.67, y: -15.65), controlPoint2: CGPoint(x: 13.84, y: -16.4))
            dientesInternosPath.addCurve(to: CGPoint(x: 15.41, y: -22.5), controlPoint1: CGPoint(x: 13.8, y: -18.67), controlPoint2: CGPoint(x: 14.61, y: -20.59))
            dientesInternosPath.addCurve(to: CGPoint(x: 12.78, y: -24.14), controlPoint1: CGPoint(x: 14.55, y: -23.04), controlPoint2: CGPoint(x: 13.62, y: -23.61))
            dientesInternosPath.addCurve(to: CGPoint(x: 8.96, y: -19.54), controlPoint1: CGPoint(x: 11.44, y: -22.52), controlPoint2: CGPoint(x: 10.09, y: -20.9))
            dientesInternosPath.addCurve(to: CGPoint(x: 6.12, y: -20.61), controlPoint1: CGPoint(x: 8.05, y: -19.88), controlPoint2: CGPoint(x: 7.02, y: -20.27))
            dientesInternosPath.addCurve(to: CGPoint(x: 6.3, y: -26.58), controlPoint1: CGPoint(x: 6.18, y: -22.39), controlPoint2: CGPoint(x: 6.24, y: -24.48))
            dientesInternosPath.addCurve(to: CGPoint(x: 5.79, y: -26.68), controlPoint1: CGPoint(x: 6.13, y: -26.61), controlPoint2: CGPoint(x: 5.96, y: -26.64))
            dientesInternosPath.addCurve(to: CGPoint(x: 3.26, y: -27.15), controlPoint1: CGPoint(x: 4.94, y: -26.84), controlPoint2: CGPoint(x: 4.06, y: -27))
            dientesInternosPath.close()
            dientesInternosPath.move(to: CGPoint(x: 32, y: -0))
            dientesInternosPath.addCurve(to: CGPoint(x: 0, y: 32), controlPoint1: CGPoint(x: 32, y: 17.67), controlPoint2: CGPoint(x: 17.67, y: 32))
            dientesInternosPath.addCurve(to: CGPoint(x: -32, y: -0), controlPoint1: CGPoint(x: -17.67, y: 32), controlPoint2: CGPoint(x: -32, y: 17.67))
            dientesInternosPath.addCurve(to: CGPoint(x: -8.35, y: -30.9), controlPoint1: CGPoint(x: -32, y: -14.78), controlPoint2: CGPoint(x: -21.97, y: -27.23))
            dientesInternosPath.addCurve(to: CGPoint(x: -4.57, y: -31.68), controlPoint1: CGPoint(x: -7.12, y: -31.23), controlPoint2: CGPoint(x: -5.86, y: -31.49))
            dientesInternosPath.addCurve(to: CGPoint(x: 0, y: -32), controlPoint1: CGPoint(x: -3.08, y: -31.89), controlPoint2: CGPoint(x: -1.55, y: -32))
            dientesInternosPath.addCurve(to: CGPoint(x: 32, y: -0), controlPoint1: CGPoint(x: 17.67, y: -32), controlPoint2: CGPoint(x: 32, y: -17.67))
            dientesInternosPath.close()
            dientesInternosPath.lineCapStyle = CGLineCap.round
            
            dientesInternosPath.lineJoinStyle = CGLineJoin.round
            
            context?.saveGState()
            context?.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            color.setFill()
            dientesInternosPath.fill()
            
            ////// DientesInternos Inner Shadow
            context?.saveGState()
            context?.clip(to: dientesInternosPath.bounds)
            context?.setShadow(offset: CGSize(width: 0, height: 0), blur: 0)
            context?.setAlpha(((shadow2.shadowColor as! UIColor).cgColor).alpha)
            context?.beginTransparencyLayer(auxiliaryInfo: nil)
            let dientesInternosOpaqueShadow = (shadow2.shadowColor as! UIColor).withAlphaComponent(1)
            context?.setShadow(offset: shadow2.shadowOffset, blur: shadow2.shadowBlurRadius, color: dientesInternosOpaqueShadow.cgColor)
            context?.setBlendMode(CGBlendMode.sourceOut)
            context?.beginTransparencyLayer(auxiliaryInfo: nil)
            
            dientesInternosOpaqueShadow.setFill()
            dientesInternosPath.fill()
            
            context?.endTransparencyLayer()
            context?.endTransparencyLayer()
            context?.restoreGState()
            
            context?.restoreGState()
            
            color4.setStroke()
            dientesInternosPath.lineWidth = 0.1
            dientesInternosPath.stroke()
            
            context?.restoreGState()
        }
        
        
        if (ocultarCentro) {
            //// Circulo Drawing
            context?.saveGState()
            context?.translateBy(x: 50, y: 50)
            context?.scaleBy(x: sizeCentro2, y: sizeCentro2)
            
            let circuloPath = UIBezierPath()
            circuloPath.move(to: CGPoint(x: -0, y: -20.64))
            circuloPath.addCurve(to: CGPoint(x: -13.33, y: -15.76), controlPoint1: CGPoint(x: -5.08, y: -20.64), controlPoint2: CGPoint(x: -9.73, y: -18.8))
            circuloPath.addCurve(to: CGPoint(x: -20.64, y: 0), controlPoint1: CGPoint(x: -17.8, y: -11.97), controlPoint2: CGPoint(x: -20.64, y: -6.32))
            circuloPath.addCurve(to: CGPoint(x: -0, y: 20.64), controlPoint1: CGPoint(x: -20.64, y: 11.4), controlPoint2: CGPoint(x: -11.4, y: 20.64))
            circuloPath.addCurve(to: CGPoint(x: 20.64, y: 0), controlPoint1: CGPoint(x: 11.4, y: 20.64), controlPoint2: CGPoint(x: 20.64, y: 11.4))
            circuloPath.addCurve(to: CGPoint(x: -0, y: -20.64), controlPoint1: CGPoint(x: 20.64, y: -11.4), controlPoint2: CGPoint(x: 11.4, y: -20.64))
            circuloPath.close()
            circuloPath.move(to: CGPoint(x: 32.25, y: 0))
            circuloPath.addCurve(to: CGPoint(x: -0, y: 32.25), controlPoint1: CGPoint(x: 32.25, y: 17.81), controlPoint2: CGPoint(x: 17.81, y: 32.25))
            circuloPath.addCurve(to: CGPoint(x: -32.25, y: 0), controlPoint1: CGPoint(x: -17.81, y: 32.25), controlPoint2: CGPoint(x: -32.25, y: 17.81))
            circuloPath.addCurve(to: CGPoint(x: -22.13, y: -23.46), controlPoint1: CGPoint(x: -32.25, y: -9.24), controlPoint2: CGPoint(x: -28.36, y: -17.58))
            circuloPath.addCurve(to: CGPoint(x: -0, y: -32.25), controlPoint1: CGPoint(x: -16.35, y: -28.91), controlPoint2: CGPoint(x: -8.57, y: -32.25))
            circuloPath.addCurve(to: CGPoint(x: 32.25, y: 0), controlPoint1: CGPoint(x: 17.81, y: -32.25), controlPoint2: CGPoint(x: 32.25, y: -17.81))
            circuloPath.close()
            circuloPath.lineCapStyle = CGLineCap.round
            
            circuloPath.lineJoinStyle = CGLineJoin.round
            
            context?.saveGState()
            context?.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            color.setFill()
            circuloPath.fill()
            
            ////// Circulo Inner Shadow
            context?.saveGState()
            context?.clip(to: circuloPath.bounds)
            context?.setShadow(offset: CGSize(width: 0, height: 0), blur: 0)
            context?.setAlpha(((shadow3.shadowColor as! UIColor).cgColor).alpha)
            context?.beginTransparencyLayer(auxiliaryInfo: nil)
            let circuloOpaqueShadow = (shadow3.shadowColor as! UIColor).withAlphaComponent(1)
            context?.setShadow(offset: shadow3.shadowOffset, blur: shadow3.shadowBlurRadius, color: circuloOpaqueShadow.cgColor)
            context?.setBlendMode(CGBlendMode.sourceOut)
            context?.beginTransparencyLayer(auxiliaryInfo: nil)
            
            circuloOpaqueShadow.setFill()
            circuloPath.fill()
            
            context?.endTransparencyLayer()
            context?.endTransparencyLayer()
            context?.restoreGState()
            
            context?.restoreGState()
            
            color4.setStroke()
            circuloPath.lineWidth = 0.3
            circuloPath.stroke()
            
            context?.restoreGState()
        }
    }
    
    func dibujarConfiguracion2(_ color: UIColor, valor: CGFloat, rotacionON: Bool, ocultarCentro: Bool, ocultarDientesEX: Bool, ocultarDientesIN: Bool) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let color4 = color.colorWithShadow(0.1)
        
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.33)
        shadow.shadowOffset = CGSize(width: 0.1, height: -0.1)
        shadow.shadowBlurRadius = 2
        let shadow2 = NSShadow()
        shadow2.shadowColor = UIColor.black.withAlphaComponent(0.25)
        shadow2.shadowOffset = CGSize(width: 0.1, height: -0.1)
        shadow2.shadowBlurRadius = 2
        let shadow3 = NSShadow()
        shadow3.shadowColor = UIColor.black.withAlphaComponent(0.25)
        shadow3.shadowOffset = CGSize(width: 0.1, height: -0.1)
        shadow3.shadowBlurRadius = 6
        
        //// Variable Declarations
        let sizeCentro2: CGFloat = valor / 2.0 + 1
        let sizeDientes3: CGFloat = (sizeCentro2 + 3) / 4.40
        let rotacionDientes: CGFloat = rotacionON == true ? valor / 2.0 * 250 : 0
        let rotacionDientes2: CGFloat = rotacionON == true ? (valor + 0.17 / 2.0) * 125 : 10.5
        
        if (ocultarDientesEX) {
            //// DientesExternos Drawing
            context?.saveGState()
            context?.translateBy(x: 50, y: 50)
            context?.rotate(by: -rotacionDientes * CGFloat(M_PI) / 180)
            
            let dientesExternosPath = UIBezierPath()
            dientesExternosPath.move(to: CGPoint(x: 11.07, y: -46.8))
            dientesExternosPath.addCurve(to: CGPoint(x: 10.61, y: -30.67), controlPoint1: CGPoint(x: 10.89, y: -40.44), controlPoint2: CGPoint(x: 10.71, y: -34.07))
            dientesExternosPath.addCurve(to: CGPoint(x: 0.55, y: -32.44), controlPoint1: CGPoint(x: 7.45, y: -31.76), controlPoint2: CGPoint(x: 4.07, y: -32.38))
            dientesExternosPath.addCurve(to: CGPoint(x: 5.71, y: -47.75), controlPoint1: CGPoint(x: 1.63, y: -35.65), controlPoint2: CGPoint(x: 3.67, y: -41.71))
            dientesExternosPath.addCurve(to: CGPoint(x: 11.07, y: -46.8), controlPoint1: CGPoint(x: 7.44, y: -47.48), controlPoint2: CGPoint(x: 9.32, y: -47.12))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: -1.07, y: -32.43))
            dientesExternosPath.addCurve(to: CGPoint(x: -11.11, y: -30.49), controlPoint1: CGPoint(x: -4.59, y: -32.31), controlPoint2: CGPoint(x: -7.96, y: -31.64))
            dientesExternosPath.addCurve(to: CGPoint(x: -11.8, y: -46.67), controlPoint1: CGPoint(x: -11.25, y: -33.89), controlPoint2: CGPoint(x: -11.53, y: -40.29))
            dientesExternosPath.addCurve(to: CGPoint(x: -6.46, y: -47.67), controlPoint1: CGPoint(x: -10.36, y: -46.94), controlPoint2: CGPoint(x: -6.46, y: -47.67))
            dientesExternosPath.addCurve(to: CGPoint(x: -1.07, y: -32.43), controlPoint1: CGPoint(x: -6.46, y: -47.67), controlPoint2: CGPoint(x: -2.2, y: -35.63))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 27.1, y: -39.62))
            dientesExternosPath.addCurve(to: CGPoint(x: 20.89, y: -24.8), controlPoint1: CGPoint(x: 24.66, y: -33.8), controlPoint2: CGPoint(x: 22.22, y: -27.96))
            dientesExternosPath.addCurve(to: CGPoint(x: 12.16, y: -30.08), controlPoint1: CGPoint(x: 18.3, y: -27), controlPoint2: CGPoint(x: 15.35, y: -28.79))
            dientesExternosPath.addCurve(to: CGPoint(x: 22.48, y: -42.49), controlPoint1: CGPoint(x: 14.34, y: -32.71), controlPoint2: CGPoint(x: 18.41, y: -37.61))
            dientesExternosPath.addCurve(to: CGPoint(x: 27.1, y: -39.62), controlPoint1: CGPoint(x: 23.96, y: -41.57), controlPoint2: CGPoint(x: 25.59, y: -40.56))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: -12.63, y: -29.89))
            dientesExternosPath.addCurve(to: CGPoint(x: -21.29, y: -24.46), controlPoint1: CGPoint(x: -15.81, y: -28.54), controlPoint2: CGPoint(x: -18.73, y: -26.7))
            dientesExternosPath.addCurve(to: CGPoint(x: -27.75, y: -39.26), controlPoint1: CGPoint(x: -22.66, y: -27.59), controlPoint2: CGPoint(x: -25.21, y: -33.44))
            dientesExternosPath.addCurve(to: CGPoint(x: -23.12, y: -42.13), controlPoint1: CGPoint(x: -26.27, y: -40.18), controlPoint2: CGPoint(x: -24.63, y: -41.19))
            dientesExternosPath.addCurve(to: CGPoint(x: -12.63, y: -29.89), controlPoint1: CGPoint(x: -18.99, y: -37.31), controlPoint2: CGPoint(x: -14.84, y: -32.47))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 39.47, y: -27.11))
            dientesExternosPath.addCurve(to: CGPoint(x: 28.41, y: -15.62), controlPoint1: CGPoint(x: 35.14, y: -22.61), controlPoint2: CGPoint(x: 30.8, y: -18.09))
            dientesExternosPath.addCurve(to: CGPoint(x: 22.16, y: -23.68), controlPoint1: CGPoint(x: 26.76, y: -18.63), controlPoint2: CGPoint(x: 24.65, y: -21.34))
            dientesExternosPath.addCurve(to: CGPoint(x: 36.19, y: -31.47), controlPoint1: CGPoint(x: 25.15, y: -25.34), controlPoint2: CGPoint(x: 30.68, y: -28.41))
            dientesExternosPath.addCurve(to: CGPoint(x: 39.47, y: -27.11), controlPoint1: CGPoint(x: 37.24, y: -30.07), controlPoint2: CGPoint(x: 38.4, y: -28.54))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: -22.52, y: -23.33))
            dientesExternosPath.addCurve(to: CGPoint(x: -28.66, y: -15.17), controlPoint1: CGPoint(x: -24.97, y: -20.96), controlPoint2: CGPoint(x: -27.05, y: -18.21))
            dientesExternosPath.addCurve(to: CGPoint(x: -39.94, y: -26.56), controlPoint1: CGPoint(x: -31.07, y: -17.6), controlPoint2: CGPoint(x: -35.52, y: -22.09))
            dientesExternosPath.addCurve(to: CGPoint(x: -36.66, y: -30.92), controlPoint1: CGPoint(x: -38.89, y: -27.96), controlPoint2: CGPoint(x: -37.74, y: -29.5))
            dientesExternosPath.addCurve(to: CGPoint(x: -22.52, y: -23.33), controlPoint1: CGPoint(x: -31.1, y: -27.94), controlPoint2: CGPoint(x: -25.52, y: -24.94))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 46.5, y: -10.96))
            dientesExternosPath.addCurve(to: CGPoint(x: 32.12, y: -4.28), controlPoint1: CGPoint(x: 40.88, y: -8.35), controlPoint2: CGPoint(x: 35.25, y: -5.74))
            dientesExternosPath.addCurve(to: CGPoint(x: 29.22, y: -14.05), controlPoint1: CGPoint(x: 31.67, y: -7.74), controlPoint2: CGPoint(x: 30.67, y: -11.03))
            dientesExternosPath.addCurve(to: CGPoint(x: 45.01, y: -16.21), controlPoint1: CGPoint(x: 32.63, y: -14.52), controlPoint2: CGPoint(x: 38.83, y: -15.37))
            dientesExternosPath.addCurve(to: CGPoint(x: 46.5, y: -10.96), controlPoint1: CGPoint(x: 45.49, y: -14.53), controlPoint2: CGPoint(x: 46.01, y: -12.68))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: -29.42, y: -13.62))
            dientesExternosPath.addCurve(to: CGPoint(x: -32.19, y: -3.79), controlPoint1: CGPoint(x: -30.83, y: -10.57), controlPoint2: CGPoint(x: -31.78, y: -7.27))
            dientesExternosPath.addCurve(to: CGPoint(x: -46.75, y: -10.3), controlPoint1: CGPoint(x: -35.33, y: -5.2), controlPoint2: CGPoint(x: -41.05, y: -7.76))
            dientesExternosPath.addCurve(to: CGPoint(x: -45.26, y: -15.56), controlPoint1: CGPoint(x: -46.27, y: -11.98), controlPoint2: CGPoint(x: -45.75, y: -13.84))
            dientesExternosPath.addCurve(to: CGPoint(x: -29.42, y: -13.62), controlPoint1: CGPoint(x: -39.05, y: -14.8), controlPoint2: CGPoint(x: -32.82, y: -14.03))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 47.75, y: 1.21))
            dientesExternosPath.addCurve(to: CGPoint(x: 47.25, y: 6.65), controlPoint1: CGPoint(x: 47.59, y: 2.95), controlPoint2: CGPoint(x: 47.41, y: 4.87))
            dientesExternosPath.addCurve(to: CGPoint(x: 31.49, y: 7.66), controlPoint1: CGPoint(x: 41.1, y: 7.04), controlPoint2: CGPoint(x: 34.93, y: 7.44))
            dientesExternosPath.addCurve(to: CGPoint(x: 32.4, y: -0.02), controlPoint1: CGPoint(x: 32.08, y: 5.19), controlPoint2: CGPoint(x: 32.4, y: 2.62))
            dientesExternosPath.addCurve(to: CGPoint(x: 32.31, y: -2.49), controlPoint1: CGPoint(x: 32.4, y: -0.85), controlPoint2: CGPoint(x: 32.37, y: -1.67))
            dientesExternosPath.addCurve(to: CGPoint(x: 47.75, y: 1.21), controlPoint1: CGPoint(x: 35.67, y: -1.68), controlPoint2: CGPoint(x: 41.72, y: -0.23))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: -31.37, y: 8.11))
            dientesExternosPath.addCurve(to: CGPoint(x: -47.25, y: 7.33), controlPoint1: CGPoint(x: -31.37, y: 8.11), controlPoint2: CGPoint(x: -41.04, y: 7.64))
            dientesExternosPath.addCurve(to: CGPoint(x: -47.75, y: 1.89), controlPoint1: CGPoint(x: -47.41, y: 5.59), controlPoint2: CGPoint(x: -47.59, y: 3.67))
            dientesExternosPath.addCurve(to: CGPoint(x: -32.34, y: -2.03), controlPoint1: CGPoint(x: -41.72, y: 0.35), controlPoint2: CGPoint(x: -35.67, y: -1.19))
            dientesExternosPath.addCurve(to: CGPoint(x: -31.37, y: 8.11), controlPoint1: CGPoint(x: -33, y: 4), controlPoint2: CGPoint(x: -31.37, y: 8.11))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 44.03, y: 18.45))
            dientesExternosPath.addCurve(to: CGPoint(x: 41.61, y: 23.34), controlPoint1: CGPoint(x: 43.26, y: 20.01), controlPoint2: CGPoint(x: 42.4, y: 21.74))
            dientesExternosPath.addCurve(to: CGPoint(x: 26.55, y: 18.56), controlPoint1: CGPoint(x: 35.73, y: 21.48), controlPoint2: CGPoint(x: 29.84, y: 19.61))
            dientesExternosPath.addCurve(to: CGPoint(x: 31, y: 9.43), controlPoint1: CGPoint(x: 28.48, y: 15.8), controlPoint2: CGPoint(x: 30, y: 12.73))
            dientesExternosPath.addCurve(to: CGPoint(x: 44.03, y: 18.45), controlPoint1: CGPoint(x: 33.85, y: 11.4), controlPoint2: CGPoint(x: 38.95, y: 14.93))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: -26.29, y: 18.93))
            dientesExternosPath.addCurve(to: CGPoint(x: -41.37, y: 23.95), controlPoint1: CGPoint(x: -29.57, y: 20.02), controlPoint2: CGPoint(x: -35.48, y: 21.99))
            dientesExternosPath.addCurve(to: CGPoint(x: -43.79, y: 19.06), controlPoint1: CGPoint(x: -42.14, y: 22.39), controlPoint2: CGPoint(x: -43, y: 20.66))
            dientesExternosPath.addCurve(to: CGPoint(x: -30.87, y: 9.84), controlPoint1: CGPoint(x: -38.74, y: 15.46), controlPoint2: CGPoint(x: -33.68, y: 11.84))
            dientesExternosPath.addCurve(to: CGPoint(x: -26.29, y: 18.93), controlPoint1: CGPoint(x: -29.83, y: 13.13), controlPoint2: CGPoint(x: -28.27, y: 16.19))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 3.03, y: 47.75))
            dientesExternosPath.addLine(to: CGPoint(x: -2.41, y: 47.75))
            dientesExternosPath.addCurve(to: CGPoint(x: -4.87, y: 32.03), controlPoint1: CGPoint(x: -3.37, y: 41.6), controlPoint2: CGPoint(x: -4.34, y: 35.44))
            dientesExternosPath.addCurve(to: CGPoint(x: 5.27, y: 31.97), controlPoint1: CGPoint(x: -3.28, y: 32.27), controlPoint2: CGPoint(x: 3.55, y: 32.25))
            dientesExternosPath.addCurve(to: CGPoint(x: 3.03, y: 47.75), controlPoint1: CGPoint(x: 4.78, y: 35.4), controlPoint2: CGPoint(x: 3.9, y: 41.59))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 34.37, y: 33.18))
            dientesExternosPath.addCurve(to: CGPoint(x: 30.35, y: 36.86), controlPoint1: CGPoint(x: 33.08, y: 34.36), controlPoint2: CGPoint(x: 31.66, y: 35.65))
            dientesExternosPath.addCurve(to: CGPoint(x: 18.01, y: 26.93), controlPoint1: CGPoint(x: 25.53, y: 32.98), controlPoint2: CGPoint(x: 20.7, y: 29.1))
            dientesExternosPath.addCurve(to: CGPoint(x: 25.46, y: 20.03), controlPoint1: CGPoint(x: 20.84, y: 25.03), controlPoint2: CGPoint(x: 23.35, y: 22.7))
            dientesExternosPath.addCurve(to: CGPoint(x: 34.37, y: 33.18), controlPoint1: CGPoint(x: 27.4, y: 22.91), controlPoint2: CGPoint(x: 30.89, y: 28.05))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: -17.65, y: 27.16))
            dientesExternosPath.addCurve(to: CGPoint(x: -29.91, y: 37.32), controlPoint1: CGPoint(x: -20.31, y: 29.37), controlPoint2: CGPoint(x: -25.12, y: 33.35))
            dientesExternosPath.addCurve(to: CGPoint(x: -33.93, y: 33.64), controlPoint1: CGPoint(x: -31.19, y: 36.14), controlPoint2: CGPoint(x: -32.61, y: 34.84))
            dientesExternosPath.addCurve(to: CGPoint(x: -25.2, y: 20.36), controlPoint1: CGPoint(x: -30.52, y: 28.45), controlPoint2: CGPoint(x: -27.09, y: 23.24))
            dientesExternosPath.addCurve(to: CGPoint(x: -17.65, y: 27.16), controlPoint1: CGPoint(x: -23.06, y: 23), controlPoint2: CGPoint(x: -20.51, y: 25.3))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 20.05, y: 43.41))
            dientesExternosPath.addCurve(to: CGPoint(x: 14.98, y: 45.38), controlPoint1: CGPoint(x: 18.43, y: 44.04), controlPoint2: CGPoint(x: 16.64, y: 44.73))
            dientesExternosPath.addCurve(to: CGPoint(x: 7.04, y: 31.63), controlPoint1: CGPoint(x: 11.88, y: 40.01), controlPoint2: CGPoint(x: 8.77, y: 34.62))
            dientesExternosPath.addCurve(to: CGPoint(x: 16.47, y: 27.9), controlPoint1: CGPoint(x: 10.41, y: 30.88), controlPoint2: CGPoint(x: 13.58, y: 29.61))
            dientesExternosPath.addCurve(to: CGPoint(x: 20.05, y: 43.41), controlPoint1: CGPoint(x: 17.25, y: 31.28), controlPoint2: CGPoint(x: 18.66, y: 37.35))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: -6.64, y: 31.71))
            dientesExternosPath.addCurve(to: CGPoint(x: -14.41, y: 45.63), controlPoint1: CGPoint(x: -8.33, y: 34.73), controlPoint2: CGPoint(x: -11.37, y: 40.19))
            dientesExternosPath.addCurve(to: CGPoint(x: -19.48, y: 43.65), controlPoint1: CGPoint(x: -16.03, y: 44.99), controlPoint2: CGPoint(x: -17.82, y: 44.3))
            dientesExternosPath.addCurve(to: CGPoint(x: -16.12, y: 28.1), controlPoint1: CGPoint(x: -18.17, y: 37.57), controlPoint2: CGPoint(x: -16.85, y: 31.48))
            dientesExternosPath.addCurve(to: CGPoint(x: -6.64, y: 31.71), controlPoint1: CGPoint(x: -13.22, y: 29.77), controlPoint2: CGPoint(x: -10.02, y: 31.01))
            dientesExternosPath.close()
            dientesExternosPath.lineCapStyle = CGLineCap.round
            
            dientesExternosPath.lineJoinStyle = CGLineJoin.round
            
            context?.saveGState()
            context?.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            color.setFill()
            dientesExternosPath.fill()
            
            ////// DientesExternos Inner Shadow
            context?.saveGState()
            context?.clip(to: dientesExternosPath.bounds)
            context?.setShadow(offset: CGSize(width: 0, height: 0), blur: 0)
            context?.setAlpha(((shadow2.shadowColor as! UIColor).cgColor).alpha)
            context?.beginTransparencyLayer(auxiliaryInfo: nil)
            let dientesExternosOpaqueShadow = (shadow2.shadowColor as! UIColor).withAlphaComponent(1)
            context?.setShadow(offset: shadow2.shadowOffset, blur: shadow2.shadowBlurRadius, color: dientesExternosOpaqueShadow.cgColor)
            context?.setBlendMode(CGBlendMode.sourceOut)
            context?.beginTransparencyLayer(auxiliaryInfo: nil)
            
            dientesExternosOpaqueShadow.setFill()
            dientesExternosPath.fill()
            
            context?.endTransparencyLayer()
            context?.endTransparencyLayer()
            context?.restoreGState()
            
            context?.restoreGState()
            
            color4.setStroke()
            dientesExternosPath.lineWidth = 0.2
            dientesExternosPath.stroke()
            
            context?.restoreGState()
        }
        
        
        //// DientesInternos Drawing
        context?.saveGState()
        context?.translateBy(x: 50, y: 50)
        context?.rotate(by: -rotacionDientes2 * CGFloat(M_PI) / 180)
        context?.scaleBy(x: sizeDientes3, y: sizeDientes3)
        
        let dientesInternosPath = UIBezierPath()
        dientesInternosPath.move(to: CGPoint(x: 3.42, y: -30.75))
        dientesInternosPath.addCurve(to: CGPoint(x: 0.87, y: -23.18), controlPoint1: CGPoint(x: 2.47, y: -27.92), controlPoint2: CGPoint(x: 1.54, y: -25.18))
        dientesInternosPath.addCurve(to: CGPoint(x: -1.25, y: -23.17), controlPoint1: CGPoint(x: 0.18, y: -23.18), controlPoint2: CGPoint(x: -0.55, y: -23.17))
        dientesInternosPath.addCurve(to: CGPoint(x: -3.9, y: -30.7), controlPoint1: CGPoint(x: -1.95, y: -25.15), controlPoint2: CGPoint(x: -2.91, y: -27.88))
        dientesInternosPath.addCurve(to: CGPoint(x: -7.85, y: -29.94), controlPoint1: CGPoint(x: -5.25, y: -30.53), controlPoint2: CGPoint(x: -6.56, y: -30.27))
        dientesInternosPath.addCurve(to: CGPoint(x: -7.5, y: -21.96), controlPoint1: CGPoint(x: -7.72, y: -26.95), controlPoint2: CGPoint(x: -7.59, y: -24.06))
        dientesInternosPath.addCurve(to: CGPoint(x: -9.48, y: -21.18), controlPoint1: CGPoint(x: -8.15, y: -21.7), controlPoint2: CGPoint(x: -8.83, y: -21.43))
        dientesInternosPath.addCurve(to: CGPoint(x: -14.68, y: -27.24), controlPoint1: CGPoint(x: -10.85, y: -22.77), controlPoint2: CGPoint(x: -12.73, y: -24.97))
        dientesInternosPath.addCurve(to: CGPoint(x: -18.08, y: -25.11), controlPoint1: CGPoint(x: -15.86, y: -26.61), controlPoint2: CGPoint(x: -16.99, y: -25.89))
        dientesInternosPath.addCurve(to: CGPoint(x: -14.89, y: -17.8), controlPoint1: CGPoint(x: -16.89, y: -22.38), controlPoint2: CGPoint(x: -15.73, y: -19.73))
        dientesInternosPath.addCurve(to: CGPoint(x: -16.47, y: -16.34), controlPoint1: CGPoint(x: -15.4, y: -17.33), controlPoint2: CGPoint(x: -15.95, y: -16.82))
        dientesInternosPath.addCurve(to: CGPoint(x: -23.51, y: -20.12), controlPoint1: CGPoint(x: -18.33, y: -17.34), controlPoint2: CGPoint(x: -20.88, y: -18.71))
        dientesInternosPath.addCurve(to: CGPoint(x: -25.91, y: -16.92), controlPoint1: CGPoint(x: -24.37, y: -19.11), controlPoint2: CGPoint(x: -25.18, y: -18.04))
        dientesInternosPath.addCurve(to: CGPoint(x: -20.3, y: -11.25), controlPoint1: CGPoint(x: -23.82, y: -14.81), controlPoint2: CGPoint(x: -21.78, y: -12.76))
        dientesInternosPath.addCurve(to: CGPoint(x: -21.26, y: -9.29), controlPoint1: CGPoint(x: -20.61, y: -10.61), controlPoint2: CGPoint(x: -20.94, y: -9.93))
        dientesInternosPath.addCurve(to: CGPoint(x: -29.2, y: -10.26), controlPoint1: CGPoint(x: -23.36, y: -9.54), controlPoint2: CGPoint(x: -26.24, y: -9.9))
        dientesInternosPath.addCurve(to: CGPoint(x: -30.27, y: -6.42), controlPoint1: CGPoint(x: -29.64, y: -9.01), controlPoint2: CGPoint(x: -30, y: -7.73))
        dientesInternosPath.addCurve(to: CGPoint(x: -22.99, y: -3.17), controlPoint1: CGPoint(x: -27.56, y: -5.21), controlPoint2: CGPoint(x: -24.93, y: -4.03))
        dientesInternosPath.addCurve(to: CGPoint(x: -23.18, y: -0.95), controlPoint1: CGPoint(x: -23.05, y: -2.45), controlPoint2: CGPoint(x: -23.12, y: -1.68))
        dientesInternosPath.addCurve(to: CGPoint(x: -30.92, y: 1.02), controlPoint1: CGPoint(x: -25.24, y: -0.43), controlPoint2: CGPoint(x: -28.04, y: 0.28))
        dientesInternosPath.addCurve(to: CGPoint(x: -30.54, y: 4.97), controlPoint1: CGPoint(x: -30.88, y: 2.36), controlPoint2: CGPoint(x: -30.75, y: 3.68))
        dientesInternosPath.addCurve(to: CGPoint(x: -22.58, y: 5.37), controlPoint1: CGPoint(x: -27.58, y: 5.12), controlPoint2: CGPoint(x: -24.7, y: 5.26))
        dientesInternosPath.addCurve(to: CGPoint(x: -21.95, y: 7.52), controlPoint1: CGPoint(x: -22.37, y: 6.07), controlPoint2: CGPoint(x: -22.16, y: 6.81))
        dientesInternosPath.addCurve(to: CGPoint(x: -28.46, y: 12.16), controlPoint1: CGPoint(x: -23.68, y: 8.75), controlPoint2: CGPoint(x: -26.04, y: 10.43))
        dientesInternosPath.addCurve(to: CGPoint(x: -26.67, y: 15.7), controlPoint1: CGPoint(x: -27.94, y: 13.38), controlPoint2: CGPoint(x: -27.34, y: 14.56))
        dientesInternosPath.addCurve(to: CGPoint(x: -19.1, y: 13.18), controlPoint1: CGPoint(x: -23.86, y: 14.76), controlPoint2: CGPoint(x: -21.12, y: 13.85))
        dientesInternosPath.addCurve(to: CGPoint(x: -17.74, y: 14.96), controlPoint1: CGPoint(x: -18.66, y: 13.76), controlPoint2: CGPoint(x: -18.18, y: 14.38))
        dientesInternosPath.addCurve(to: CGPoint(x: -22.12, y: 21.63), controlPoint1: CGPoint(x: -18.91, y: 16.74), controlPoint2: CGPoint(x: -20.49, y: 19.15))
        dientesInternosPath.addCurve(to: CGPoint(x: -19.17, y: 24.28), controlPoint1: CGPoint(x: -21.2, y: 22.58), controlPoint2: CGPoint(x: -20.21, y: 23.46))
        dientesInternosPath.addCurve(to: CGPoint(x: -13.04, y: 19.2), controlPoint1: CGPoint(x: -16.89, y: 22.39), controlPoint2: CGPoint(x: -14.67, y: 20.55))
        dientesInternosPath.addCurve(to: CGPoint(x: -11.13, y: 20.36), controlPoint1: CGPoint(x: -12.41, y: 19.58), controlPoint2: CGPoint(x: -11.75, y: 19.98))
        dientesInternosPath.addCurve(to: CGPoint(x: -12.81, y: 28.17), controlPoint1: CGPoint(x: -11.58, y: 22.44), controlPoint2: CGPoint(x: -12.19, y: 25.27))
        dientesInternosPath.addCurve(to: CGPoint(x: -9.11, y: 29.58), controlPoint1: CGPoint(x: -11.62, y: 28.71), controlPoint2: CGPoint(x: -10.38, y: 29.19))
        dientesInternosPath.addCurve(to: CGPoint(x: -5.21, y: 22.61), controlPoint1: CGPoint(x: -7.66, y: 26.99), controlPoint2: CGPoint(x: -6.25, y: 24.47))
        dientesInternosPath.addCurve(to: CGPoint(x: -3.02, y: 23.01), controlPoint1: CGPoint(x: -4.5, y: 22.74), controlPoint2: CGPoint(x: -3.74, y: 22.88))
        dientesInternosPath.addCurve(to: CGPoint(x: -1.78, y: 30.89), controlPoint1: CGPoint(x: -2.69, y: 25.11), controlPoint2: CGPoint(x: -2.24, y: 27.96))
        dientesInternosPath.addCurve(to: CGPoint(x: 2.18, y: 30.86), controlPoint1: CGPoint(x: -1.19, y: 30.92), controlPoint2: CGPoint(x: 1.46, y: 30.91))
        dientesInternosPath.addCurve(to: CGPoint(x: 3.3, y: 22.97), controlPoint1: CGPoint(x: 2.6, y: 27.93), controlPoint2: CGPoint(x: 3.01, y: 25.07))
        dientesInternosPath.addCurve(to: CGPoint(x: 5.5, y: 22.54), controlPoint1: CGPoint(x: 4.02, y: 22.83), controlPoint2: CGPoint(x: 4.78, y: 22.68))
        dientesInternosPath.addCurve(to: CGPoint(x: 9.5, y: 29.46), controlPoint1: CGPoint(x: 6.57, y: 24.39), controlPoint2: CGPoint(x: 8.01, y: 26.89))
        dientesInternosPath.addCurve(to: CGPoint(x: 13.18, y: 28), controlPoint1: CGPoint(x: 10.76, y: 29.05), controlPoint2: CGPoint(x: 11.99, y: 28.56))
        dientesInternosPath.addCurve(to: CGPoint(x: 11.38, y: 20.22), controlPoint1: CGPoint(x: 12.51, y: 25.11), controlPoint2: CGPoint(x: 11.86, y: 22.3))
        dientesInternosPath.addCurve(to: CGPoint(x: 13.29, y: 19.02), controlPoint1: CGPoint(x: 12, y: 19.83), controlPoint2: CGPoint(x: 12.66, y: 19.42))
        dientesInternosPath.addCurve(to: CGPoint(x: 19.5, y: 24.02), controlPoint1: CGPoint(x: 14.95, y: 20.36), controlPoint2: CGPoint(x: 17.19, y: 22.17))
        dientesInternosPath.addCurve(to: CGPoint(x: 22.41, y: 21.33), controlPoint1: CGPoint(x: 20.53, y: 23.19), controlPoint2: CGPoint(x: 21.5, y: 22.29))
        dientesInternosPath.addCurve(to: CGPoint(x: 17.93, y: 14.73), controlPoint1: CGPoint(x: 20.75, y: 18.88), controlPoint2: CGPoint(x: 19.13, y: 16.5))
        dientesInternosPath.addCurve(to: CGPoint(x: 19.28, y: 12.91), controlPoint1: CGPoint(x: 18.37, y: 14.14), controlPoint2: CGPoint(x: 18.84, y: 13.51))
        dientesInternosPath.addCurve(to: CGPoint(x: 26.88, y: 15.32), controlPoint1: CGPoint(x: 21.31, y: 13.56), controlPoint2: CGPoint(x: 24.06, y: 14.43))
        dientesInternosPath.addCurve(to: CGPoint(x: 28.62, y: 11.77), controlPoint1: CGPoint(x: 27.54, y: 14.18), controlPoint2: CGPoint(x: 28.12, y: 13))
        dientesInternosPath.addCurve(to: CGPoint(x: 22.05, y: 7.22), controlPoint1: CGPoint(x: 26.18, y: 10.08), controlPoint2: CGPoint(x: 23.81, y: 8.44))
        dientesInternosPath.addCurve(to: CGPoint(x: 22.65, y: 5.04), controlPoint1: CGPoint(x: 22.25, y: 6.51), controlPoint2: CGPoint(x: 22.46, y: 5.75))
        dientesInternosPath.addCurve(to: CGPoint(x: 30.61, y: 4.53), controlPoint1: CGPoint(x: 24.78, y: 4.9), controlPoint2: CGPoint(x: 27.66, y: 4.72))
        dientesInternosPath.addCurve(to: CGPoint(x: 30.93, y: 0.58), controlPoint1: CGPoint(x: 30.8, y: 3.24), controlPoint2: CGPoint(x: 30.91, y: 1.92))
        dientesInternosPath.addCurve(to: CGPoint(x: 23.17, y: -1.28), controlPoint1: CGPoint(x: 28.05, y: -0.11), controlPoint2: CGPoint(x: 25.24, y: -0.78))
        dientesInternosPath.addCurve(to: CGPoint(x: 22.94, y: -3.52), controlPoint1: CGPoint(x: 23.09, y: -2.01), controlPoint2: CGPoint(x: 23.01, y: -2.79))
        dientesInternosPath.addCurve(to: CGPoint(x: 30.17, y: -6.87), controlPoint1: CGPoint(x: 24.87, y: -4.41), controlPoint2: CGPoint(x: 27.49, y: -5.63))
        dientesInternosPath.addCurve(to: CGPoint(x: 29.05, y: -10.68), controlPoint1: CGPoint(x: 29.88, y: -8.18), controlPoint2: CGPoint(x: 29.5, y: -9.45))
        dientesInternosPath.addCurve(to: CGPoint(x: 21.12, y: -9.6), controlPoint1: CGPoint(x: 26.1, y: -10.28), controlPoint2: CGPoint(x: 23.23, y: -9.89))
        dientesInternosPath.addCurve(to: CGPoint(x: 20.12, y: -11.57), controlPoint1: CGPoint(x: 20.79, y: -10.25), controlPoint2: CGPoint(x: 20.44, y: -10.93))
        dientesInternosPath.addCurve(to: CGPoint(x: 25.65, y: -17.31), controlPoint1: CGPoint(x: 21.59, y: -13.1), controlPoint2: CGPoint(x: 23.59, y: -15.18))
        dientesInternosPath.addCurve(to: CGPoint(x: 23.2, y: -20.47), controlPoint1: CGPoint(x: 24.9, y: -18.42), controlPoint2: CGPoint(x: 24.08, y: -19.47))
        dientesInternosPath.addCurve(to: CGPoint(x: 16.22, y: -16.59), controlPoint1: CGPoint(x: 20.6, y: -19.02), controlPoint2: CGPoint(x: 18.06, y: -17.62))
        dientesInternosPath.addCurve(to: CGPoint(x: 14.6, y: -18.04), controlPoint1: CGPoint(x: 15.68, y: -17.07), controlPoint2: CGPoint(x: 15.12, y: -17.57))
        dientesInternosPath.addCurve(to: CGPoint(x: 17.68, y: -25.39), controlPoint1: CGPoint(x: 15.42, y: -19.99), controlPoint2: CGPoint(x: 16.53, y: -22.65))
        dientesInternosPath.addCurve(to: CGPoint(x: 14.26, y: -27.47), controlPoint1: CGPoint(x: 16.59, y: -26.15), controlPoint2: CGPoint(x: 15.45, y: -26.85))
        dientesInternosPath.addCurve(to: CGPoint(x: 9.14, y: -21.32), controlPoint1: CGPoint(x: 12.35, y: -25.17), controlPoint2: CGPoint(x: 10.49, y: -22.94))
        dientesInternosPath.addCurve(to: CGPoint(x: 7.15, y: -22.08), controlPoint1: CGPoint(x: 8.49, y: -21.57), controlPoint2: CGPoint(x: 7.8, y: -21.83))
        dientesInternosPath.addCurve(to: CGPoint(x: 7.38, y: -30.05), controlPoint1: CGPoint(x: 7.21, y: -24.18), controlPoint2: CGPoint(x: 7.29, y: -27.07))
        dientesInternosPath.addCurve(to: CGPoint(x: 3.42, y: -30.75), controlPoint1: CGPoint(x: 6.09, y: -30.37), controlPoint2: CGPoint(x: 4.77, y: -30.6))
        dientesInternosPath.close()
        dientesInternosPath.move(to: CGPoint(x: 31.92, y: 0))
        dientesInternosPath.addCurve(to: CGPoint(x: 0, y: 31.92), controlPoint1: CGPoint(x: 31.92, y: 17.63), controlPoint2: CGPoint(x: 17.63, y: 31.92))
        dientesInternosPath.addCurve(to: CGPoint(x: -31.92, y: 0), controlPoint1: CGPoint(x: -17.63, y: 31.92), controlPoint2: CGPoint(x: -31.92, y: 17.63))
        dientesInternosPath.addCurve(to: CGPoint(x: -13.66, y: -28.86), controlPoint1: CGPoint(x: -31.92, y: -12.74), controlPoint2: CGPoint(x: -24.46, y: -23.74))
        dientesInternosPath.addCurve(to: CGPoint(x: -2.58, y: -31.82), controlPoint1: CGPoint(x: -10.25, y: -30.47), controlPoint2: CGPoint(x: -6.52, y: -31.5))
        dientesInternosPath.addCurve(to: CGPoint(x: 0, y: -31.92), controlPoint1: CGPoint(x: -1.73, y: -31.89), controlPoint2: CGPoint(x: -0.87, y: -31.92))
        dientesInternosPath.addCurve(to: CGPoint(x: 31.92, y: 0), controlPoint1: CGPoint(x: 17.63, y: -31.92), controlPoint2: CGPoint(x: 31.92, y: -17.63))
        dientesInternosPath.close()
        dientesInternosPath.lineCapStyle = CGLineCap.round
        
        dientesInternosPath.lineJoinStyle = CGLineJoin.round
        
        context?.saveGState()
        context?.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        color.setFill()
        dientesInternosPath.fill()
        
        ////// DientesInternos Inner Shadow
        context?.saveGState()
        context?.clip(to: dientesInternosPath.bounds)
        context?.setShadow(offset: CGSize(width: 0, height: 0), blur: 0)
        context?.setAlpha(((shadow2.shadowColor as! UIColor).cgColor).alpha)
        context?.beginTransparencyLayer(auxiliaryInfo: nil)
        let dientesInternosOpaqueShadow = (shadow2.shadowColor as! UIColor).withAlphaComponent(1)
        context?.setShadow(offset: shadow2.shadowOffset, blur: shadow2.shadowBlurRadius, color: dientesInternosOpaqueShadow.cgColor)
        context?.setBlendMode(CGBlendMode.sourceOut)
        context?.beginTransparencyLayer(auxiliaryInfo: nil)
        
        dientesInternosOpaqueShadow.setFill()
        dientesInternosPath.fill()
        
        context?.endTransparencyLayer()
        context?.endTransparencyLayer()
        context?.restoreGState()
        
        context?.restoreGState()
        
        color4.setStroke()
        dientesInternosPath.lineWidth = 0.3
        dientesInternosPath.stroke()
        
        context?.restoreGState()
        
        
        if (ocultarCentro) {
            //// Circulo Drawing
            context?.saveGState()
            context?.translateBy(x: 50, y: 50)
            context?.scaleBy(x: sizeCentro2, y: sizeCentro2)
            
            let circuloPath = UIBezierPath()
            circuloPath.move(to: CGPoint(x: -0, y: -20.64))
            circuloPath.addCurve(to: CGPoint(x: -13.33, y: -15.76), controlPoint1: CGPoint(x: -5.08, y: -20.64), controlPoint2: CGPoint(x: -9.73, y: -18.8))
            circuloPath.addCurve(to: CGPoint(x: -20.64, y: 0), controlPoint1: CGPoint(x: -17.8, y: -11.97), controlPoint2: CGPoint(x: -20.64, y: -6.32))
            circuloPath.addCurve(to: CGPoint(x: -0, y: 20.64), controlPoint1: CGPoint(x: -20.64, y: 11.4), controlPoint2: CGPoint(x: -11.4, y: 20.64))
            circuloPath.addCurve(to: CGPoint(x: 20.64, y: 0), controlPoint1: CGPoint(x: 11.4, y: 20.64), controlPoint2: CGPoint(x: 20.64, y: 11.4))
            circuloPath.addCurve(to: CGPoint(x: -0, y: -20.64), controlPoint1: CGPoint(x: 20.64, y: -11.4), controlPoint2: CGPoint(x: 11.4, y: -20.64))
            circuloPath.close()
            circuloPath.move(to: CGPoint(x: 32.25, y: 0))
            circuloPath.addCurve(to: CGPoint(x: -0, y: 32.25), controlPoint1: CGPoint(x: 32.25, y: 17.81), controlPoint2: CGPoint(x: 17.81, y: 32.25))
            circuloPath.addCurve(to: CGPoint(x: -32.25, y: 0), controlPoint1: CGPoint(x: -17.81, y: 32.25), controlPoint2: CGPoint(x: -32.25, y: 17.81))
            circuloPath.addCurve(to: CGPoint(x: -22.13, y: -23.46), controlPoint1: CGPoint(x: -32.25, y: -9.24), controlPoint2: CGPoint(x: -28.36, y: -17.58))
            circuloPath.addCurve(to: CGPoint(x: -0, y: -32.25), controlPoint1: CGPoint(x: -16.35, y: -28.91), controlPoint2: CGPoint(x: -8.57, y: -32.25))
            circuloPath.addCurve(to: CGPoint(x: 32.25, y: 0), controlPoint1: CGPoint(x: 17.81, y: -32.25), controlPoint2: CGPoint(x: 32.25, y: -17.81))
            circuloPath.close()
            circuloPath.lineCapStyle = CGLineCap.round
            
            circuloPath.lineJoinStyle = CGLineJoin.round
            
            context?.saveGState()
            context?.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            color.setFill()
            circuloPath.fill()
            
            ////// Circulo Inner Shadow
            context?.saveGState()
            context?.clip(to: circuloPath.bounds)
            context?.setShadow(offset: CGSize(width: 0, height: 0), blur: 0)
            context?.setAlpha(((shadow3.shadowColor as! UIColor).cgColor).alpha)
            context?.beginTransparencyLayer(auxiliaryInfo: nil)
            let circuloOpaqueShadow = (shadow3.shadowColor as! UIColor).withAlphaComponent(1)
            context?.setShadow(offset: shadow3.shadowOffset, blur: shadow3.shadowBlurRadius, color: circuloOpaqueShadow.cgColor)
            context?.setBlendMode(CGBlendMode.sourceOut)
            context?.beginTransparencyLayer(auxiliaryInfo: nil)
            
            circuloOpaqueShadow.setFill()
            circuloPath.fill()
            
            context?.endTransparencyLayer()
            context?.endTransparencyLayer()
            context?.restoreGState()
            
            context?.restoreGState()
            
            color4.setStroke()
            circuloPath.lineWidth = 0.3
            circuloPath.stroke()
            
            context?.restoreGState()
        }
    }
    
    func dibujarConfiguracion3(_ color: UIColor, valor: CGFloat, rotacionON: Bool, ocultarCentro: Bool, ocultarDientesEX: Bool, ocultarDientesIN: Bool) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let color4 = color.colorWithShadow(0.1)
        
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.33)
        shadow.shadowOffset = CGSize(width: 0.1, height: -0.1)
        shadow.shadowBlurRadius = 2
        let shadow2 = NSShadow()
        shadow2.shadowColor = UIColor.black.withAlphaComponent(0.25)
        shadow2.shadowOffset = CGSize(width: 0.1, height: -0.1)
        shadow2.shadowBlurRadius = 2
        let shadow3 = NSShadow()
        shadow3.shadowColor = UIColor.black.withAlphaComponent(0.25)
        shadow3.shadowOffset = CGSize(width: 0.1, height: -0.1)
        shadow3.shadowBlurRadius = 6
        
        //// Variable Declarations
        let sizeCentro2: CGFloat = valor / 2.0 + 1
        let sizeDientesIN3: CGFloat = (valor + 3) / 5.40
        let rotacionDientesIN2: CGFloat = rotacionON == true ? (valor + 0.1875 / 2.0) * 225 : 0
        let rotacionDientesEX3: CGFloat = rotacionON == true ? valor / 2.0 * 450 : 0
        
        if (ocultarCentro) {
            //// Circulo Drawing
            context?.saveGState()
            context?.translateBy(x: 50, y: 50)
            context?.scaleBy(x: sizeCentro2, y: sizeCentro2)
            
            let circuloPath = UIBezierPath()
            circuloPath.move(to: CGPoint(x: -0, y: -12.96))
            circuloPath.addCurve(to: CGPoint(x: -8.37, y: -9.89), controlPoint1: CGPoint(x: -3.19, y: -12.96), controlPoint2: CGPoint(x: -6.11, y: -11.81))
            circuloPath.addCurve(to: CGPoint(x: -12.96, y: 0), controlPoint1: CGPoint(x: -11.18, y: -7.52), controlPoint2: CGPoint(x: -12.96, y: -3.97))
            circuloPath.addCurve(to: CGPoint(x: -0, y: 12.96), controlPoint1: CGPoint(x: -12.96, y: 7.16), controlPoint2: CGPoint(x: -7.16, y: 12.96))
            circuloPath.addCurve(to: CGPoint(x: 12.96, y: 0), controlPoint1: CGPoint(x: 7.16, y: 12.96), controlPoint2: CGPoint(x: 12.96, y: 7.16))
            circuloPath.addCurve(to: CGPoint(x: -0, y: -12.96), controlPoint1: CGPoint(x: 12.96, y: -7.16), controlPoint2: CGPoint(x: 7.16, y: -12.96))
            circuloPath.close()
            circuloPath.move(to: CGPoint(x: 20.25, y: 0))
            circuloPath.addCurve(to: CGPoint(x: -0, y: 20.25), controlPoint1: CGPoint(x: 20.25, y: 11.18), controlPoint2: CGPoint(x: 11.18, y: 20.25))
            circuloPath.addCurve(to: CGPoint(x: -20.25, y: 0), controlPoint1: CGPoint(x: -11.18, y: 20.25), controlPoint2: CGPoint(x: -20.25, y: 11.18))
            circuloPath.addCurve(to: CGPoint(x: -13.89, y: -14.73), controlPoint1: CGPoint(x: -20.25, y: -5.8), controlPoint2: CGPoint(x: -17.81, y: -11.04))
            circuloPath.addCurve(to: CGPoint(x: -0, y: -20.25), controlPoint1: CGPoint(x: -10.27, y: -18.15), controlPoint2: CGPoint(x: -5.38, y: -20.25))
            circuloPath.addCurve(to: CGPoint(x: 20.25, y: 0), controlPoint1: CGPoint(x: 11.18, y: -20.25), controlPoint2: CGPoint(x: 20.25, y: -11.18))
            circuloPath.close()
            circuloPath.lineCapStyle = CGLineCap.round
            
            circuloPath.lineJoinStyle = CGLineJoin.round
            
            context?.saveGState()
            context?.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            color.setFill()
            circuloPath.fill()
            
            ////// Circulo Inner Shadow
            context?.saveGState()
            context?.clip(to: circuloPath.bounds)
            context?.setShadow(offset: CGSize(width: 0, height: 0), blur: 0)
            context?.setAlpha(((shadow3.shadowColor as! UIColor).cgColor).alpha)
            context?.beginTransparencyLayer(auxiliaryInfo: nil)
            let circuloOpaqueShadow = (shadow3.shadowColor as! UIColor).withAlphaComponent(1)
            context?.setShadow(offset: shadow3.shadowOffset, blur: shadow3.shadowBlurRadius, color: circuloOpaqueShadow.cgColor)
            context?.setBlendMode(CGBlendMode.sourceOut)
            context?.beginTransparencyLayer(auxiliaryInfo: nil)
            
            circuloOpaqueShadow.setFill()
            circuloPath.fill()
            
            context?.endTransparencyLayer()
            context?.endTransparencyLayer()
            context?.restoreGState()
            
            context?.restoreGState()
            
            color4.setStroke()
            circuloPath.lineWidth = 0.3
            circuloPath.stroke()
            
            context?.restoreGState()
        }
        
        
        if (ocultarDientesIN) {
            //// DientesInternos Drawing
            context?.saveGState()
            context?.translateBy(x: 50, y: 50)
            context?.rotate(by: -(rotacionDientesIN2 - 360) * CGFloat(M_PI) / 180)
            context?.scaleBy(x: sizeDientesIN3, y: sizeDientesIN3)
            
            let dientesInternosPath = UIBezierPath()
            dientesInternosPath.move(to: CGPoint(x: 6.86, y: -61.58))
            dientesInternosPath.addCurve(to: CGPoint(x: 1.75, y: -46.43), controlPoint1: CGPoint(x: 4.95, y: -55.91), controlPoint2: CGPoint(x: 3.09, y: -50.42))
            dientesInternosPath.addCurve(to: CGPoint(x: -2.49, y: -46.4), controlPoint1: CGPoint(x: 0.36, y: -46.42), controlPoint2: CGPoint(x: -1.11, y: -46.41))
            dientesInternosPath.addCurve(to: CGPoint(x: -7.82, y: -61.47), controlPoint1: CGPoint(x: -3.9, y: -50.36), controlPoint2: CGPoint(x: -5.83, y: -55.83))
            dientesInternosPath.addCurve(to: CGPoint(x: -15.71, y: -59.94), controlPoint1: CGPoint(x: -10.51, y: -61.13), controlPoint2: CGPoint(x: -13.14, y: -60.62))
            dientesInternosPath.addCurve(to: CGPoint(x: -15.02, y: -43.97), controlPoint1: CGPoint(x: -15.46, y: -53.97), controlPoint2: CGPoint(x: -15.21, y: -48.18))
            dientesInternosPath.addCurve(to: CGPoint(x: -18.98, y: -42.4), controlPoint1: CGPoint(x: -16.32, y: -43.46), controlPoint2: CGPoint(x: -17.68, y: -42.92))
            dientesInternosPath.addCurve(to: CGPoint(x: -29.39, y: -54.55), controlPoint1: CGPoint(x: -21.73, y: -45.6), controlPoint2: CGPoint(x: -25.5, y: -50.01))
            dientesInternosPath.addCurve(to: CGPoint(x: -36.2, y: -50.29), controlPoint1: CGPoint(x: -31.76, y: -53.28), controlPoint2: CGPoint(x: -34.03, y: -51.85))
            dientesInternosPath.addCurve(to: CGPoint(x: -29.81, y: -35.65), controlPoint1: CGPoint(x: -33.81, y: -44.82), controlPoint2: CGPoint(x: -31.5, y: -39.52))
            dientesInternosPath.addCurve(to: CGPoint(x: -32.98, y: -32.72), controlPoint1: CGPoint(x: -30.84, y: -34.7), controlPoint2: CGPoint(x: -31.93, y: -33.68))
            dientesInternosPath.addCurve(to: CGPoint(x: -47.07, y: -40.28), controlPoint1: CGPoint(x: -36.7, y: -34.72), controlPoint2: CGPoint(x: -41.81, y: -37.46))
            dientesInternosPath.addCurve(to: CGPoint(x: -51.88, y: -33.88), controlPoint1: CGPoint(x: -48.81, y: -38.26), controlPoint2: CGPoint(x: -50.41, y: -36.12))
            dientesInternosPath.addCurve(to: CGPoint(x: -40.64, y: -22.54), controlPoint1: CGPoint(x: -47.69, y: -29.65), controlPoint2: CGPoint(x: -43.62, y: -25.54))
            dientesInternosPath.addCurve(to: CGPoint(x: -42.57, y: -18.6), controlPoint1: CGPoint(x: -41.27, y: -21.26), controlPoint2: CGPoint(x: -41.94, y: -19.89))
            dientesInternosPath.addCurve(to: CGPoint(x: -58.47, y: -20.54), controlPoint1: CGPoint(x: -46.79, y: -19.11), controlPoint2: CGPoint(x: -52.55, y: -19.82))
            dientesInternosPath.addCurve(to: CGPoint(x: -60.62, y: -12.86), controlPoint1: CGPoint(x: -59.34, y: -18.05), controlPoint2: CGPoint(x: -60.07, y: -15.48))
            dientesInternosPath.addCurve(to: CGPoint(x: -46.04, y: -6.34), controlPoint1: CGPoint(x: -55.2, y: -10.43), controlPoint2: CGPoint(x: -49.92, y: -8.08))
            dientesInternosPath.addCurve(to: CGPoint(x: -46.42, y: -1.91), controlPoint1: CGPoint(x: -46.16, y: -4.9), controlPoint2: CGPoint(x: -46.29, y: -3.37))
            dientesInternosPath.addCurve(to: CGPoint(x: -61.92, y: 2.03), controlPoint1: CGPoint(x: -50.54, y: -0.86), controlPoint2: CGPoint(x: -56.16, y: 0.57))
            dientesInternosPath.addCurve(to: CGPoint(x: -61.16, y: 9.96), controlPoint1: CGPoint(x: -61.84, y: 4.72), controlPoint2: CGPoint(x: -61.58, y: 7.37))
            dientesInternosPath.addCurve(to: CGPoint(x: -45.21, y: 10.75), controlPoint1: CGPoint(x: -55.23, y: 10.25), controlPoint2: CGPoint(x: -49.46, y: 10.54))
            dientesInternosPath.addCurve(to: CGPoint(x: -43.95, y: 15.05), controlPoint1: CGPoint(x: -44.8, y: 12.15), controlPoint2: CGPoint(x: -44.37, y: 13.64))
            dientesInternosPath.addCurve(to: CGPoint(x: -56.99, y: 24.35), controlPoint1: CGPoint(x: -47.43, y: 17.53), controlPoint2: CGPoint(x: -52.15, y: 20.89))
            dientesInternosPath.addCurve(to: CGPoint(x: -53.4, y: 31.44), controlPoint1: CGPoint(x: -55.94, y: 26.8), controlPoint2: CGPoint(x: -54.74, y: 29.16))
            dientesInternosPath.addCurve(to: CGPoint(x: -38.25, y: 26.39), controlPoint1: CGPoint(x: -47.77, y: 29.56), controlPoint2: CGPoint(x: -42.29, y: 27.74))
            dientesInternosPath.addCurve(to: CGPoint(x: -35.52, y: 29.95), controlPoint1: CGPoint(x: -37.36, y: 27.55), controlPoint2: CGPoint(x: -36.41, y: 28.79))
            dientesInternosPath.addCurve(to: CGPoint(x: -44.3, y: 43.31), controlPoint1: CGPoint(x: -37.86, y: 33.51), controlPoint2: CGPoint(x: -41.04, y: 38.35))
            dientesInternosPath.addCurve(to: CGPoint(x: -38.39, y: 48.63), controlPoint1: CGPoint(x: -42.45, y: 45.21), controlPoint2: CGPoint(x: -40.48, y: 46.98))
            dientesInternosPath.addCurve(to: CGPoint(x: -26.1, y: 38.44), controlPoint1: CGPoint(x: -33.83, y: 44.84), controlPoint2: CGPoint(x: -29.38, y: 41.16))
            dientesInternosPath.addCurve(to: CGPoint(x: -22.28, y: 40.77), controlPoint1: CGPoint(x: -24.86, y: 39.2), controlPoint2: CGPoint(x: -23.53, y: 40.01))
            dientesInternosPath.addCurve(to: CGPoint(x: -25.66, y: 56.41), controlPoint1: CGPoint(x: -23.18, y: 44.94), controlPoint2: CGPoint(x: -24.4, y: 50.6))
            dientesInternosPath.addCurve(to: CGPoint(x: -18.24, y: 59.23), controlPoint1: CGPoint(x: -23.26, y: 57.5), controlPoint2: CGPoint(x: -20.78, y: 58.44))
            dientesInternosPath.addCurve(to: CGPoint(x: -10.44, y: 45.28), controlPoint1: CGPoint(x: -15.34, y: 54.04), controlPoint2: CGPoint(x: -12.52, y: 49))
            dientesInternosPath.addCurve(to: CGPoint(x: -6.04, y: 46.07), controlPoint1: CGPoint(x: -9.01, y: 45.54), controlPoint2: CGPoint(x: -7.48, y: 45.81))
            dientesInternosPath.addCurve(to: CGPoint(x: -3.57, y: 61.85), controlPoint1: CGPoint(x: -5.38, y: 50.28), controlPoint2: CGPoint(x: -4.49, y: 55.99))
            dientesInternosPath.addCurve(to: CGPoint(x: 4.37, y: 61.8), controlPoint1: CGPoint(x: -2.39, y: 61.92), controlPoint2: CGPoint(x: 2.93, y: 61.9))
            dientesInternosPath.addCurve(to: CGPoint(x: 6.62, y: 45.99), controlPoint1: CGPoint(x: 5.21, y: 55.93), controlPoint2: CGPoint(x: 6.02, y: 50.21))
            dientesInternosPath.addCurve(to: CGPoint(x: 11.02, y: 45.14), controlPoint1: CGPoint(x: 8.05, y: 45.72), controlPoint2: CGPoint(x: 9.58, y: 45.42))
            dientesInternosPath.addCurve(to: CGPoint(x: 19.01, y: 58.98), controlPoint1: CGPoint(x: 13.15, y: 48.83), controlPoint2: CGPoint(x: 16.04, y: 53.84))
            dientesInternosPath.addCurve(to: CGPoint(x: 26.39, y: 56.07), controlPoint1: CGPoint(x: 21.55, y: 58.17), controlPoint2: CGPoint(x: 24.01, y: 57.19))
            dientesInternosPath.addCurve(to: CGPoint(x: 22.79, y: 40.5), controlPoint1: CGPoint(x: 25.05, y: 50.29), controlPoint2: CGPoint(x: 23.75, y: 44.65))
            dientesInternosPath.addCurve(to: CGPoint(x: 26.61, y: 38.09), controlPoint1: CGPoint(x: 24.04, y: 39.71), controlPoint2: CGPoint(x: 25.36, y: 38.88))
            dientesInternosPath.addCurve(to: CGPoint(x: 39.05, y: 48.1), controlPoint1: CGPoint(x: 29.93, y: 40.77), controlPoint2: CGPoint(x: 34.43, y: 44.39))
            dientesInternosPath.addCurve(to: CGPoint(x: 44.87, y: 42.72), controlPoint1: CGPoint(x: 41.1, y: 46.43), controlPoint2: CGPoint(x: 43.05, y: 44.64))
            dientesInternosPath.addCurve(to: CGPoint(x: 35.9, y: 29.5), controlPoint1: CGPoint(x: 41.54, y: 37.81), controlPoint2: CGPoint(x: 38.3, y: 33.03))
            dientesInternosPath.addCurve(to: CGPoint(x: 38.61, y: 25.86), controlPoint1: CGPoint(x: 36.79, y: 28.31), controlPoint2: CGPoint(x: 37.73, y: 27.05))
            dientesInternosPath.addCurve(to: CGPoint(x: 53.83, y: 30.69), controlPoint1: CGPoint(x: 42.68, y: 27.15), controlPoint2: CGPoint(x: 48.19, y: 28.9))
            dientesInternosPath.addCurve(to: CGPoint(x: 57.31, y: 23.57), controlPoint1: CGPoint(x: 55.14, y: 28.4), controlPoint2: CGPoint(x: 56.3, y: 26.02))
            dientesInternosPath.addCurve(to: CGPoint(x: 44.15, y: 14.46), controlPoint1: CGPoint(x: 52.43, y: 20.19), controlPoint2: CGPoint(x: 47.67, y: 16.9))
            dientesInternosPath.addCurve(to: CGPoint(x: 45.36, y: 10.09), controlPoint1: CGPoint(x: 44.55, y: 13.03), controlPoint2: CGPoint(x: 44.97, y: 11.51))
            dientesInternosPath.addCurve(to: CGPoint(x: 61.3, y: 9.07), controlPoint1: CGPoint(x: 49.62, y: 9.82), controlPoint2: CGPoint(x: 55.39, y: 9.45))
            dientesInternosPath.addCurve(to: CGPoint(x: 61.94, y: 1.16), controlPoint1: CGPoint(x: 61.68, y: 6.48), controlPoint2: CGPoint(x: 61.9, y: 3.84))
            dientesInternosPath.addCurve(to: CGPoint(x: 46.39, y: -2.56), controlPoint1: CGPoint(x: 56.17, y: -0.22), controlPoint2: CGPoint(x: 50.54, y: -1.57))
            dientesInternosPath.addCurve(to: CGPoint(x: 45.94, y: -7.04), controlPoint1: CGPoint(x: 46.24, y: -4.03), controlPoint2: CGPoint(x: 46.08, y: -5.59))
            dientesInternosPath.addCurve(to: CGPoint(x: 60.42, y: -13.76), controlPoint1: CGPoint(x: 49.8, y: -8.84), controlPoint2: CGPoint(x: 55.04, y: -11.27))
            dientesInternosPath.addCurve(to: CGPoint(x: 58.16, y: -21.39), controlPoint1: CGPoint(x: 59.83, y: -16.37), controlPoint2: CGPoint(x: 59.07, y: -18.92))
            dientesInternosPath.addCurve(to: CGPoint(x: 42.29, y: -19.22), controlPoint1: CGPoint(x: 52.26, y: -20.58), controlPoint2: CGPoint(x: 46.51, y: -19.8))
            dientesInternosPath.addCurve(to: CGPoint(x: 40.29, y: -23.17), controlPoint1: CGPoint(x: 41.63, y: -20.52), controlPoint2: CGPoint(x: 40.94, y: -21.89))
            dientesInternosPath.addCurve(to: CGPoint(x: 51.35, y: -34.67), controlPoint1: CGPoint(x: 43.23, y: -26.23), controlPoint2: CGPoint(x: 47.24, y: -30.39))
            dientesInternosPath.addCurve(to: CGPoint(x: 46.46, y: -40.99), controlPoint1: CGPoint(x: 49.86, y: -36.88), controlPoint2: CGPoint(x: 48.22, y: -38.99))
            dientesInternosPath.addCurve(to: CGPoint(x: 32.47, y: -33.22), controlPoint1: CGPoint(x: 41.24, y: -38.09), controlPoint2: CGPoint(x: 36.17, y: -35.28))
            dientesInternosPath.addCurve(to: CGPoint(x: 29.23, y: -36.13), controlPoint1: CGPoint(x: 31.41, y: -34.18), controlPoint2: CGPoint(x: 30.29, y: -35.18))
            dientesInternosPath.addCurve(to: CGPoint(x: 35.41, y: -50.85), controlPoint1: CGPoint(x: 30.87, y: -40.02), controlPoint2: CGPoint(x: 33.11, y: -45.35))
            dientesInternosPath.addCurve(to: CGPoint(x: 28.55, y: -55), controlPoint1: CGPoint(x: 33.22, y: -52.37), controlPoint2: CGPoint(x: 30.93, y: -53.76))
            dientesInternosPath.addCurve(to: CGPoint(x: 18.31, y: -42.69), controlPoint1: CGPoint(x: 24.72, y: -50.4), controlPoint2: CGPoint(x: 21.01, y: -45.94))
            dientesInternosPath.addCurve(to: CGPoint(x: 14.31, y: -44.21), controlPoint1: CGPoint(x: 17, y: -43.19), controlPoint2: CGPoint(x: 15.61, y: -43.72))
            dientesInternosPath.addCurve(to: CGPoint(x: 14.77, y: -60.18), controlPoint1: CGPoint(x: 14.43, y: -48.42), controlPoint2: CGPoint(x: 14.6, y: -54.21))
            dientesInternosPath.addCurve(to: CGPoint(x: 6.86, y: -61.58), controlPoint1: CGPoint(x: 12.19, y: -60.81), controlPoint2: CGPoint(x: 9.55, y: -61.28))
            dientesInternosPath.close()
            dientesInternosPath.move(to: CGPoint(x: 63.92, y: 0))
            dientesInternosPath.addCurve(to: CGPoint(x: 0, y: 63.92), controlPoint1: CGPoint(x: 63.92, y: 35.3), controlPoint2: CGPoint(x: 35.3, y: 63.92))
            dientesInternosPath.addCurve(to: CGPoint(x: -63.92, y: 0), controlPoint1: CGPoint(x: -35.3, y: 63.92), controlPoint2: CGPoint(x: -63.92, y: 35.3))
            dientesInternosPath.addCurve(to: CGPoint(x: -27.35, y: -57.79), controlPoint1: CGPoint(x: -63.92, y: -25.52), controlPoint2: CGPoint(x: -48.97, y: -47.54))
            dientesInternosPath.addCurve(to: CGPoint(x: -5.17, y: -63.72), controlPoint1: CGPoint(x: -20.53, y: -61.02), controlPoint2: CGPoint(x: -13.05, y: -63.09))
            dientesInternosPath.addCurve(to: CGPoint(x: 0, y: -63.92), controlPoint1: CGPoint(x: -3.46, y: -63.85), controlPoint2: CGPoint(x: -1.74, y: -63.92))
            dientesInternosPath.addCurve(to: CGPoint(x: 63.92, y: 0), controlPoint1: CGPoint(x: 35.3, y: -63.92), controlPoint2: CGPoint(x: 63.92, y: -35.3))
            dientesInternosPath.close()
            dientesInternosPath.lineCapStyle = CGLineCap.round
            
            dientesInternosPath.lineJoinStyle = CGLineJoin.round
            
            context?.saveGState()
            context?.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            color.setFill()
            dientesInternosPath.fill()
            
            ////// DientesInternos Inner Shadow
            context?.saveGState()
            context?.clip(to: dientesInternosPath.bounds)
            context?.setShadow(offset: CGSize(width: 0, height: 0), blur: 0)
            context?.setAlpha(((shadow2.shadowColor as! UIColor).cgColor).alpha)
            context?.beginTransparencyLayer(auxiliaryInfo: nil)
            let dientesInternosOpaqueShadow = (shadow2.shadowColor as! UIColor).withAlphaComponent(1)
            context?.setShadow(offset: shadow2.shadowOffset, blur: shadow2.shadowBlurRadius, color: dientesInternosOpaqueShadow.cgColor)
            context?.setBlendMode(CGBlendMode.sourceOut)
            context?.beginTransparencyLayer(auxiliaryInfo: nil)
            
            dientesInternosOpaqueShadow.setFill()
            dientesInternosPath.fill()
            
            context?.endTransparencyLayer()
            context?.endTransparencyLayer()
            context?.restoreGState()
            
            context?.restoreGState()
            
            color4.setStroke()
            dientesInternosPath.lineWidth = 0.3
            dientesInternosPath.stroke()
            
            context?.restoreGState()
        }
        
        
        if (ocultarDientesEX) {
            //// DientesExternos Drawing
            context?.saveGState()
            context?.translateBy(x: 50, y: 50)
            context?.rotate(by: -rotacionDientesEX3 * CGFloat(M_PI) / 180)
            
            let dientesExternosPath = UIBezierPath()
            dientesExternosPath.move(to: CGPoint(x: 10.84, y: -45.82))
            dientesExternosPath.addCurve(to: CGPoint(x: 10.56, y: -36.14), controlPoint1: CGPoint(x: 10.74, y: -42.44), controlPoint2: CGPoint(x: 10.65, y: -39.06))
            dientesExternosPath.addCurve(to: CGPoint(x: 15.81, y: -34.15), controlPoint1: CGPoint(x: 12.21, y: -35.51), controlPoint2: CGPoint(x: 14.13, y: -34.78))
            dientesExternosPath.addCurve(to: CGPoint(x: 22.01, y: -41.6), controlPoint1: CGPoint(x: 17.68, y: -36.4), controlPoint2: CGPoint(x: 19.84, y: -39))
            dientesExternosPath.addCurve(to: CGPoint(x: 26.54, y: -38.79), controlPoint1: CGPoint(x: 23.46, y: -40.7), controlPoint2: CGPoint(x: 25.05, y: -39.71))
            dientesExternosPath.addCurve(to: CGPoint(x: 22.83, y: -29.95), controlPoint1: CGPoint(x: 25.24, y: -35.71), controlPoint2: CGPoint(x: 23.95, y: -32.62))
            dientesExternosPath.addCurve(to: CGPoint(x: 27.05, y: -26.15), controlPoint1: CGPoint(x: 24.15, y: -28.76), controlPoint2: CGPoint(x: 25.7, y: -27.37))
            dientesExternosPath.addCurve(to: CGPoint(x: 35.43, y: -30.81), controlPoint1: CGPoint(x: 29.59, y: -27.56), controlPoint2: CGPoint(x: 32.51, y: -29.19))
            dientesExternosPath.addCurve(to: CGPoint(x: 38.64, y: -26.54), controlPoint1: CGPoint(x: 36.46, y: -29.44), controlPoint2: CGPoint(x: 37.59, y: -27.94))
            dientesExternosPath.addCurve(to: CGPoint(x: 32.08, y: -19.72), controlPoint1: CGPoint(x: 36.36, y: -24.17), controlPoint2: CGPoint(x: 34.07, y: -21.79))
            dientesExternosPath.addCurve(to: CGPoint(x: 34.68, y: -14.59), controlPoint1: CGPoint(x: 32.89, y: -18.12), controlPoint2: CGPoint(x: 33.85, y: -16.23))
            dientesExternosPath.addCurve(to: CGPoint(x: 44.07, y: -15.88), controlPoint1: CGPoint(x: 37.53, y: -14.98), controlPoint2: CGPoint(x: 40.8, y: -15.43))
            dientesExternosPath.addCurve(to: CGPoint(x: 45.53, y: -10.73), controlPoint1: CGPoint(x: 44.54, y: -14.23), controlPoint2: CGPoint(x: 45.05, y: -12.41))
            dientesExternosPath.addCurve(to: CGPoint(x: 37.04, y: -6.79), controlPoint1: CGPoint(x: 42.58, y: -9.36), controlPoint2: CGPoint(x: 39.62, y: -7.99))
            dientesExternosPath.addCurve(to: CGPoint(x: 37.62, y: -1), controlPoint1: CGPoint(x: 37.22, y: -4.99), controlPoint2: CGPoint(x: 37.44, y: -2.84))
            dientesExternosPath.addCurve(to: CGPoint(x: 46.75, y: 1.18), controlPoint1: CGPoint(x: 40.39, y: -0.34), controlPoint2: CGPoint(x: 43.57, y: 0.42))
            dientesExternosPath.addCurve(to: CGPoint(x: 46.26, y: 6.51), controlPoint1: CGPoint(x: 46.59, y: 2.89), controlPoint2: CGPoint(x: 46.42, y: 4.77))
            dientesExternosPath.addCurve(to: CGPoint(x: 36.98, y: 7.1), controlPoint1: CGPoint(x: 43.03, y: 6.72), controlPoint2: CGPoint(x: 39.8, y: 6.92))
            dientesExternosPath.addCurve(to: CGPoint(x: 35.42, y: 12.74), controlPoint1: CGPoint(x: 36.49, y: 8.87), controlPoint2: CGPoint(x: 35.91, y: 10.95))
            dientesExternosPath.addCurve(to: CGPoint(x: 43.11, y: 18.06), controlPoint1: CGPoint(x: 37.76, y: 14.36), controlPoint2: CGPoint(x: 40.44, y: 16.21))
            dientesExternosPath.addCurve(to: CGPoint(x: 40.74, y: 22.85), controlPoint1: CGPoint(x: 42.35, y: 19.6), controlPoint2: CGPoint(x: 41.52, y: 21.28))
            dientesExternosPath.addCurve(to: CGPoint(x: 31.87, y: 20.04), controlPoint1: CGPoint(x: 37.66, y: 21.87), controlPoint2: CGPoint(x: 34.57, y: 20.89))
            dientesExternosPath.addCurve(to: CGPoint(x: 28.39, y: 24.72), controlPoint1: CGPoint(x: 30.78, y: 21.51), controlPoint2: CGPoint(x: 29.49, y: 23.25))
            dientesExternosPath.addCurve(to: CGPoint(x: 33.65, y: 32.48), controlPoint1: CGPoint(x: 29.99, y: 27.08), controlPoint2: CGPoint(x: 31.82, y: 29.79))
            dientesExternosPath.addCurve(to: CGPoint(x: 29.71, y: 36.09), controlPoint1: CGPoint(x: 32.39, y: 33.64), controlPoint2: CGPoint(x: 31, y: 34.91))
            dientesExternosPath.addCurve(to: CGPoint(x: 22.43, y: 30.23), controlPoint1: CGPoint(x: 27.18, y: 34.05), controlPoint2: CGPoint(x: 24.65, y: 32.01))
            dientesExternosPath.addCurve(to: CGPoint(x: 17.51, y: 33.32), controlPoint1: CGPoint(x: 20.88, y: 31.21), controlPoint2: CGPoint(x: 19.06, y: 32.35))
            dientesExternosPath.addCurve(to: CGPoint(x: 19.63, y: 42.5), controlPoint1: CGPoint(x: 18.16, y: 36.11), controlPoint2: CGPoint(x: 18.9, y: 39.31))
            dientesExternosPath.addCurve(to: CGPoint(x: 14.67, y: 44.43), controlPoint1: CGPoint(x: 18.04, y: 43.11), controlPoint2: CGPoint(x: 16.29, y: 43.8))
            dientesExternosPath.addCurve(to: CGPoint(x: 9.97, y: 36.3), controlPoint1: CGPoint(x: 13.03, y: 41.6), controlPoint2: CGPoint(x: 11.4, y: 38.77))
            dientesExternosPath.addCurve(to: CGPoint(x: 4.29, y: 37.4), controlPoint1: CGPoint(x: 8.18, y: 36.65), controlPoint2: CGPoint(x: 6.08, y: 37.05))
            dientesExternosPath.addCurve(to: CGPoint(x: 2.97, y: 46.75), controlPoint1: CGPoint(x: 3.89, y: 40.24), controlPoint2: CGPoint(x: 3.43, y: 43.5))
            dientesExternosPath.addLine(to: CGPoint(x: -2.36, y: 46.75))
            dientesExternosPath.addCurve(to: CGPoint(x: -3.82, y: 37.45), controlPoint1: CGPoint(x: -2.87, y: 43.51), controlPoint2: CGPoint(x: -3.38, y: 40.27))
            dientesExternosPath.addCurve(to: CGPoint(x: -9.5, y: 36.43), controlPoint1: CGPoint(x: -5.61, y: 37.13), controlPoint2: CGPoint(x: -7.72, y: 36.75))
            dientesExternosPath.addCurve(to: CGPoint(x: -14.11, y: 44.67), controlPoint1: CGPoint(x: -10.9, y: 38.93), controlPoint2: CGPoint(x: -12.51, y: 41.8))
            dientesExternosPath.addCurve(to: CGPoint(x: -19.08, y: 42.74), controlPoint1: CGPoint(x: -15.7, y: 44.05), controlPoint2: CGPoint(x: -17.45, y: 43.37))
            dientesExternosPath.addCurve(to: CGPoint(x: -17.09, y: 33.54), controlPoint1: CGPoint(x: -18.38, y: 39.54), controlPoint2: CGPoint(x: -17.69, y: 36.33))
            dientesExternosPath.addCurve(to: CGPoint(x: -22.03, y: 30.53), controlPoint1: CGPoint(x: -18.65, y: 32.59), controlPoint2: CGPoint(x: -20.48, y: 31.47))
            dientesExternosPath.addCurve(to: CGPoint(x: -29.28, y: 36.54), controlPoint1: CGPoint(x: -24.23, y: 32.35), controlPoint2: CGPoint(x: -26.76, y: 34.45))
            dientesExternosPath.addCurve(to: CGPoint(x: -33.22, y: 32.93), controlPoint1: CGPoint(x: -30.54, y: 35.38), controlPoint2: CGPoint(x: -31.93, y: 34.11))
            dientesExternosPath.addCurve(to: CGPoint(x: -28.06, y: 25.09), controlPoint1: CGPoint(x: -31.42, y: 30.2), controlPoint2: CGPoint(x: -29.63, y: 27.47))
            dientesExternosPath.addCurve(to: CGPoint(x: -31.59, y: 20.48), controlPoint1: CGPoint(x: -29.18, y: 23.63), controlPoint2: CGPoint(x: -30.48, y: 21.93))
            dientesExternosPath.addCurve(to: CGPoint(x: -40.5, y: 23.45), controlPoint1: CGPoint(x: -34.3, y: 21.38), controlPoint2: CGPoint(x: -37.4, y: 22.42))
            dientesExternosPath.addCurve(to: CGPoint(x: -42.88, y: 18.66), controlPoint1: CGPoint(x: -41.26, y: 21.92), controlPoint2: CGPoint(x: -42.1, y: 20.23))
            dientesExternosPath.addCurve(to: CGPoint(x: -35.24, y: 13.21), controlPoint1: CGPoint(x: -40.22, y: 16.77), controlPoint2: CGPoint(x: -37.56, y: 14.87))
            dientesExternosPath.addCurve(to: CGPoint(x: -36.87, y: 7.64), controlPoint1: CGPoint(x: -35.76, y: 11.44), controlPoint2: CGPoint(x: -36.36, y: 9.38))
            dientesExternosPath.addCurve(to: CGPoint(x: -46.26, y: 7.18), controlPoint1: CGPoint(x: -39.87, y: 7.49), controlPoint2: CGPoint(x: -43.43, y: 7.32))
            dientesExternosPath.addCurve(to: CGPoint(x: -46.75, y: 1.85), controlPoint1: CGPoint(x: -46.42, y: 5.47), controlPoint2: CGPoint(x: -46.59, y: 3.59))
            dientesExternosPath.addCurve(to: CGPoint(x: -37.63, y: -0.47), controlPoint1: CGPoint(x: -43.58, y: 1.04), controlPoint2: CGPoint(x: -40.4, y: 0.23))
            dientesExternosPath.addCurve(to: CGPoint(x: -37.14, y: -6.23), controlPoint1: CGPoint(x: -37.47, y: -2.3), controlPoint2: CGPoint(x: -37.29, y: -4.43))
            dientesExternosPath.addCurve(to: CGPoint(x: -45.77, y: -10.09), controlPoint1: CGPoint(x: -39.76, y: -7.4), controlPoint2: CGPoint(x: -42.77, y: -8.74))
            dientesExternosPath.addCurve(to: CGPoint(x: -44.31, y: -15.23), controlPoint1: CGPoint(x: -45.3, y: -11.73), controlPoint2: CGPoint(x: -44.79, y: -13.55))
            dientesExternosPath.addCurve(to: CGPoint(x: -34.9, y: -14.08), controlPoint1: CGPoint(x: -41.03, y: -14.83), controlPoint2: CGPoint(x: -37.75, y: -14.43))
            dientesExternosPath.addCurve(to: CGPoint(x: -32.38, y: -19.22), controlPoint1: CGPoint(x: -34.09, y: -15.72), controlPoint2: CGPoint(x: -33.17, y: -17.61))
            dientesExternosPath.addCurve(to: CGPoint(x: -39.11, y: -26.01), controlPoint1: CGPoint(x: -34.42, y: -21.27), controlPoint2: CGPoint(x: -36.76, y: -23.64))
            dientesExternosPath.addCurve(to: CGPoint(x: -35.9, y: -30.28), controlPoint1: CGPoint(x: -38.08, y: -27.37), controlPoint2: CGPoint(x: -36.95, y: -28.88))
            dientesExternosPath.addCurve(to: CGPoint(x: -27.45, y: -25.74), controlPoint1: CGPoint(x: -32.95, y: -28.69), controlPoint2: CGPoint(x: -30, y: -27.11))
            dientesExternosPath.addCurve(to: CGPoint(x: -23.3, y: -29.58), controlPoint1: CGPoint(x: -26.12, y: -26.96), controlPoint2: CGPoint(x: -24.6, y: -28.38))
            dientesExternosPath.addCurve(to: CGPoint(x: -27.16, y: -38.44), controlPoint1: CGPoint(x: -24.47, y: -32.25), controlPoint2: CGPoint(x: -25.82, y: -35.35))
            dientesExternosPath.addCurve(to: CGPoint(x: -22.64, y: -41.25), controlPoint1: CGPoint(x: -25.72, y: -39.34), controlPoint2: CGPoint(x: -24.12, y: -40.33))
            dientesExternosPath.addCurve(to: CGPoint(x: -16.34, y: -33.9), controlPoint1: CGPoint(x: -20.44, y: -38.69), controlPoint2: CGPoint(x: -18.24, y: -36.12))
            dientesExternosPath.addCurve(to: CGPoint(x: -11.14, y: -35.96), controlPoint1: CGPoint(x: -14.69, y: -34.55), controlPoint2: CGPoint(x: -12.78, y: -35.31))
            dientesExternosPath.addCurve(to: CGPoint(x: -11.56, y: -45.69), controlPoint1: CGPoint(x: -11.26, y: -38.89), controlPoint2: CGPoint(x: -11.41, y: -42.3))
            dientesExternosPath.addCurve(to: CGPoint(x: -7.96, y: -46.37), controlPoint1: CGPoint(x: -10.76, y: -45.84), controlPoint2: CGPoint(x: -9.18, y: -46.14))
            dientesExternosPath.addLine(to: CGPoint(x: -7.83, y: -46.39))
            dientesExternosPath.addCurve(to: CGPoint(x: -6.83, y: -46.58), controlPoint1: CGPoint(x: -7.44, y: -46.47), controlPoint2: CGPoint(x: -7.09, y: -46.53))
            dientesExternosPath.addCurve(to: CGPoint(x: -6.32, y: -46.68), controlPoint1: CGPoint(x: -6.51, y: -46.64), controlPoint2: CGPoint(x: -6.32, y: -46.68))
            dientesExternosPath.addCurve(to: CGPoint(x: -6.27, y: -46.54), controlPoint1: CGPoint(x: -6.32, y: -46.68), controlPoint2: CGPoint(x: -6.3, y: -46.63))
            dientesExternosPath.addCurve(to: CGPoint(x: -6.19, y: -46.29), controlPoint1: CGPoint(x: -6.25, y: -46.47), controlPoint2: CGPoint(x: -6.22, y: -46.39))
            dientesExternosPath.addCurve(to: CGPoint(x: -3.09, y: -37.51), controlPoint1: CGPoint(x: -5.7, y: -44.91), controlPoint2: CGPoint(x: -4.33, y: -41.03))
            dientesExternosPath.addCurve(to: CGPoint(x: 2.49, y: -37.55), controlPoint1: CGPoint(x: -1.32, y: -37.52), controlPoint2: CGPoint(x: 0.72, y: -37.54))
            dientesExternosPath.addCurve(to: CGPoint(x: 5.18, y: -45.54), controlPoint1: CGPoint(x: 3.31, y: -39.98), controlPoint2: CGPoint(x: 4.24, y: -42.74))
            dientesExternosPath.addCurve(to: CGPoint(x: 5.59, y: -46.75), controlPoint1: CGPoint(x: 5.31, y: -45.91), controlPoint2: CGPoint(x: 5.59, y: -46.75))
            dientesExternosPath.addCurve(to: CGPoint(x: 10.84, y: -45.82), controlPoint1: CGPoint(x: 7.28, y: -46.48), controlPoint2: CGPoint(x: 9.13, y: -46.14))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 11.74, y: -32.2))
            dientesExternosPath.addCurve(to: CGPoint(x: 1, y: -21.94), controlPoint1: CGPoint(x: 8.97, y: -31.06), controlPoint2: CGPoint(x: 1.8, y: -28.23))
            dientesExternosPath.addCurve(to: CGPoint(x: 5.11, y: -9), controlPoint1: CGPoint(x: 0.24, y: -15.95), controlPoint2: CGPoint(x: 2.95, y: -11.43))
            dientesExternosPath.addLine(to: CGPoint(x: 5.94, y: -9))
            dientesExternosPath.addCurve(to: CGPoint(x: 7.62, y: -8.88), controlPoint1: CGPoint(x: 6.8, y: -9), controlPoint2: CGPoint(x: 7.24, y: -9))
            dientesExternosPath.addCurve(to: CGPoint(x: 8.85, y: -7.74), controlPoint1: CGPoint(x: 8.27, y: -8.65), controlPoint2: CGPoint(x: 8.67, y: -8.24))
            dientesExternosPath.addCurve(to: CGPoint(x: 9, y: -5.94), controlPoint1: CGPoint(x: 9, y: -7.26), controlPoint2: CGPoint(x: 9, y: -6.82))
            dientesExternosPath.addCurve(to: CGPoint(x: 9, y: -5.08), controlPoint1: CGPoint(x: 9, y: -5.94), controlPoint2: CGPoint(x: 9, y: -5.62))
            dientesExternosPath.addCurve(to: CGPoint(x: 21.94, y: -1), controlPoint1: CGPoint(x: 11.47, y: -2.94), controlPoint2: CGPoint(x: 16, y: -0.25))
            dientesExternosPath.addCurve(to: CGPoint(x: 32.17, y: -11.83), controlPoint1: CGPoint(x: 28.29, y: -1.8), controlPoint2: CGPoint(x: 31.1, y: -9.09))
            dientesExternosPath.addCurve(to: CGPoint(x: 11.74, y: -32.2), controlPoint1: CGPoint(x: 28.7, y: -21.27), controlPoint2: CGPoint(x: 21.19, y: -28.76))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: -11.83, y: -32.17))
            dientesExternosPath.addCurve(to: CGPoint(x: -16.35, y: -30.12), controlPoint1: CGPoint(x: -13.4, y: -31.59), controlPoint2: CGPoint(x: -14.91, y: -30.91))
            dientesExternosPath.addCurve(to: CGPoint(x: -32.19, y: -11.77), controlPoint1: CGPoint(x: -23.63, y: -26.16), controlPoint2: CGPoint(x: -29.31, y: -19.64))
            dientesExternosPath.addCurve(to: CGPoint(x: -21.94, y: -1), controlPoint1: CGPoint(x: -31.07, y: -9.01), controlPoint2: CGPoint(x: -28.25, y: -1.8))
            dientesExternosPath.addCurve(to: CGPoint(x: -9, y: -5.11), controlPoint1: CGPoint(x: -15.95, y: -0.24), controlPoint2: CGPoint(x: -11.43, y: -2.95))
            dientesExternosPath.addCurve(to: CGPoint(x: -9, y: -5.94), controlPoint1: CGPoint(x: -9, y: -5.63), controlPoint2: CGPoint(x: -9, y: -5.94))
            dientesExternosPath.addCurve(to: CGPoint(x: -8.87, y: -7.66), controlPoint1: CGPoint(x: -9, y: -6.82), controlPoint2: CGPoint(x: -9, y: -7.26))
            dientesExternosPath.addCurve(to: CGPoint(x: -7.74, y: -8.85), controlPoint1: CGPoint(x: -8.66, y: -8.25), controlPoint2: CGPoint(x: -8.25, y: -8.66))
            dientesExternosPath.addCurve(to: CGPoint(x: -5.94, y: -9), controlPoint1: CGPoint(x: -7.26, y: -9), controlPoint2: CGPoint(x: -6.82, y: -9))
            dientesExternosPath.addLine(to: CGPoint(x: -5.08, y: -9))
            dientesExternosPath.addCurve(to: CGPoint(x: -1, y: -21.94), controlPoint1: CGPoint(x: -2.94, y: -11.47), controlPoint2: CGPoint(x: -0.25, y: -16))
            dientesExternosPath.addCurve(to: CGPoint(x: -11.83, y: -32.17), controlPoint1: CGPoint(x: -1.8, y: -28.29), controlPoint2: CGPoint(x: -9.09, y: -31.1))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 5, y: -5))
            dientesExternosPath.addLine(to: CGPoint(x: -5, y: -5))
            dientesExternosPath.addLine(to: CGPoint(x: -5, y: 5))
            dientesExternosPath.addLine(to: CGPoint(x: 5, y: 5))
            dientesExternosPath.addLine(to: CGPoint(x: 5, y: -5))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: 9, y: 5.11))
            dientesExternosPath.addCurve(to: CGPoint(x: 8.87, y: 7.66), controlPoint1: CGPoint(x: 9, y: 5.63), controlPoint2: CGPoint(x: 9, y: 7.26))
            dientesExternosPath.addCurve(to: CGPoint(x: 7.74, y: 8.85), controlPoint1: CGPoint(x: 8.66, y: 8.25), controlPoint2: CGPoint(x: 8.25, y: 8.66))
            dientesExternosPath.addCurve(to: CGPoint(x: 5.94, y: 9), controlPoint1: CGPoint(x: 7.26, y: 9), controlPoint2: CGPoint(x: 6.82, y: 9))
            dientesExternosPath.addLine(to: CGPoint(x: 5.08, y: 9))
            dientesExternosPath.addCurve(to: CGPoint(x: 1, y: 21.94), controlPoint1: CGPoint(x: 2.94, y: 11.47), controlPoint2: CGPoint(x: 0.25, y: 16))
            dientesExternosPath.addCurve(to: CGPoint(x: 11.83, y: 32.17), controlPoint1: CGPoint(x: 1.81, y: 28.29), controlPoint2: CGPoint(x: 9.09, y: 31.1))
            dientesExternosPath.addCurve(to: CGPoint(x: 32.19, y: 11.77), controlPoint1: CGPoint(x: 21.26, y: 28.7), controlPoint2: CGPoint(x: 28.74, y: 21.21))
            dientesExternosPath.addCurve(to: CGPoint(x: 21.94, y: 1), controlPoint1: CGPoint(x: 31.07, y: 9.01), controlPoint2: CGPoint(x: 28.25, y: 1.8))
            dientesExternosPath.addCurve(to: CGPoint(x: 9, y: 5.11), controlPoint1: CGPoint(x: 15.95, y: 0.24), controlPoint2: CGPoint(x: 11.43, y: 2.95))
            dientesExternosPath.close()
            dientesExternosPath.move(to: CGPoint(x: -21.94, y: 1))
            dientesExternosPath.addCurve(to: CGPoint(x: -32.17, y: 11.83), controlPoint1: CGPoint(x: -28.29, y: 1.8), controlPoint2: CGPoint(x: -31.1, y: 9.09))
            dientesExternosPath.addCurve(to: CGPoint(x: -11.77, y: 32.19), controlPoint1: CGPoint(x: -28.7, y: 21.26), controlPoint2: CGPoint(x: -21.21, y: 28.74))
            dientesExternosPath.addCurve(to: CGPoint(x: -1, y: 21.94), controlPoint1: CGPoint(x: -9.01, y: 31.07), controlPoint2: CGPoint(x: -1.8, y: 28.25))
            dientesExternosPath.addCurve(to: CGPoint(x: -5.11, y: 9), controlPoint1: CGPoint(x: -0.24, y: 15.95), controlPoint2: CGPoint(x: -2.95, y: 11.43))
            dientesExternosPath.addLine(to: CGPoint(x: -5.94, y: 9))
            dientesExternosPath.addCurve(to: CGPoint(x: -7.66, y: 8.87), controlPoint1: CGPoint(x: -6.82, y: 9), controlPoint2: CGPoint(x: -7.26, y: 9))
            dientesExternosPath.addCurve(to: CGPoint(x: -8.85, y: 7.74), controlPoint1: CGPoint(x: -8.25, y: 8.66), controlPoint2: CGPoint(x: -8.66, y: 8.25))
            dientesExternosPath.addCurve(to: CGPoint(x: -9, y: 5.94), controlPoint1: CGPoint(x: -9, y: 7.26), controlPoint2: CGPoint(x: -9, y: 6.82))
            dientesExternosPath.addCurve(to: CGPoint(x: -9, y: 5.08), controlPoint1: CGPoint(x: -9, y: 5.94), controlPoint2: CGPoint(x: -9, y: 5.62))
            dientesExternosPath.addCurve(to: CGPoint(x: -21.94, y: 1), controlPoint1: CGPoint(x: -11.47, y: 2.94), controlPoint2: CGPoint(x: -16, y: 0.25))
            dientesExternosPath.close()
            dientesExternosPath.lineCapStyle = CGLineCap.round
            
            dientesExternosPath.lineJoinStyle = CGLineJoin.round
            
            context?.saveGState()
            context?.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            color.setFill()
            dientesExternosPath.fill()
            
            ////// DientesExternos Inner Shadow
            context?.saveGState()
            context?.clip(to: dientesExternosPath.bounds)
            context?.setShadow(offset: CGSize(width: 0, height: 0), blur: 0)
            context?.setAlpha(((shadow2.shadowColor as! UIColor).cgColor).alpha)
            context?.beginTransparencyLayer(auxiliaryInfo: nil)
            let dientesExternosOpaqueShadow = (shadow2.shadowColor as! UIColor).withAlphaComponent(1)
            context?.setShadow(offset: shadow2.shadowOffset, blur: shadow2.shadowBlurRadius, color: dientesExternosOpaqueShadow.cgColor)
            context?.setBlendMode(CGBlendMode.sourceOut)
            context?.beginTransparencyLayer(auxiliaryInfo: nil)
            
            dientesExternosOpaqueShadow.setFill()
            dientesExternosPath.fill()
            
            context?.endTransparencyLayer()
            context?.endTransparencyLayer()
            context?.restoreGState()
            
            context?.restoreGState()
            
            color4.setStroke()
            dientesExternosPath.lineWidth = 0.3
            dientesExternosPath.stroke()
            
            context?.restoreGState()
        }
    }
}
