//
//  ViewControlB.swift
//  PINEDO
//
//  Created by Matías Correnti on 13/12/15.
//  Copyright © 2015 Correnti. All rights reserved.
//

extension UIColor {
    var coreImageColor: CoreImage.CIColor? {
        return CoreImage.CIColor(color: self)  // El resultado de Core Image color, o nil
    }
}

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}

//import Google

class ViewControlB: UIViewController, UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gesto: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
            return true
    }    
    
    var delegate : DestinationViewDelegado! = nil
    var toPassNum: String! = nil
    var toPassText: String! = nil
    var toPassTam: String! = nil
    var toPassColFondo: UIColor! = nil
    var toPassColTexto: UIColor! = nil
    var toPassSwithMarco: Bool! = nil
    var toPassSwithTextoInferior: Bool! = nil
    var toPassBotonConfiguracionON: Bool! = true
    fileprivate var rect = CGRect()
    fileprivate var conf: Bool = false
    
    @IBOutlet var layoutEspacio2: NSLayoutConstraint!
    @IBOutlet var layoutEspacio1: NSLayoutConstraint!
    @IBOutlet var layoutEspacioScrollControles: NSLayoutConstraint!
    @IBOutlet var layoutInferiorScroll: NSLayoutConstraint!
    @IBOutlet var btnConfiguracion: botonConfiguracion!
    @IBOutlet var viewConfiguracion: UIViewMio!
    
    @IBOutlet var switchMarco: UISwitch!
    @IBOutlet var switchTextoInferior: UISwitch!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var sliderTamTexto: UISlider!
    
    @IBAction func PanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        if sender.state == UIGestureRecognizerState.ended {
            // 1
            let velocity = sender.velocity(in: self.view)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 200
            
            // gesto.text = "Magnitude: \(magnitude), Slide Multiplier: \(slideMultiplier)"
            
            // 2
            let slideFactor = 0.1 * slideMultiplier     //Increase for more of a slide
            // 3
            var finalPoint = CGPoint(x:sender.view!.center.x + (velocity.x * slideFactor),
                y:sender.view!.center.y + (velocity.y * slideFactor))
            // 4
            finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
            finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
            
            // 5
            UIView.animate(withDuration: Double(slideFactor * 2), delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {sender.view!.center = finalPoint
            }, completion: nil)
        }
    }
    
    @IBAction func PinchGesture(_ sender: UIPinchGestureRecognizer) {
        if let view = sender.view {
            view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1
        }
    }
    
    @IBAction func sliderTamText(_ sender: UISlider) {
        let val = String(Int(sender.value))
        delegate.setTam(val)
        self.toPassTam = val
        
        DispatchQueue.main.async(execute: {
            self.ActualizarImagen()
            return
        })
    }
    
    @IBAction func Guardar(_ sender: UIButton) {
//        self.navigationController?.popToRootViewControllerAnimated(true)
        sender.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animate(withDuration: 1.0,
            delay: 0,
            usingSpringWithDamping: CGFloat(0.20),
            initialSpringVelocity: CGFloat(6.0),
            options: UIViewAnimationOptions.allowUserInteraction,
            animations: {
                sender.transform = CGAffineTransform.identity
            },
            completion: { Void in()  }
        )
        UIImageWriteToSavedPhotosAlbum(Img.image!, self, #selector(ViewControlB.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @IBAction func touchBtnConfiguracion(_ sender: botonConfiguracion!) {
        clickConfiguracion(sender)
    }

    @IBAction func switchMostrarMarco(_ sender: UISwitch) {
        delegate.setMarcoBool(sender.isOn)
        ActualizarImagen()
    }
    
    @IBAction func switchMostrarTextoPinedo(_ sender: UISwitch) {
        delegate.setTextoInferiorBool(sender.isOn)
        ActualizarImagen()
    }
    
    @IBAction func touchConfiguracion(_ sender: UIBarButtonItem) {
        actualizarLayoutBotonConfiguracion()
    }
    
    func actualizarLayoutBotonConfiguracion() {
//        btnConfiguracion.enabled = false
        if conf {
            self.layoutInferiorScroll.constant = 125
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: CGFloat(0.53), initialSpringVelocity: CGFloat(8.5), options: UIViewAnimationOptions.allowUserInteraction, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                }, completion:{ Void in()  }
            )
            
            layoutEspacioScrollControles.constant = 5
            layoutEspacio1.constant = 5
            layoutEspacio2.constant = 5
            UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: CGFloat(0.90), initialSpringVelocity: CGFloat(20.0), options: UIViewAnimationOptions.allowUserInteraction, animations: { () -> Void in
                self.view.layoutIfNeeded()
                }, completion:{ (finished: Bool) -> Void in
//                  self.btnConfiguracion.enabled = true
            })
        } else {
            self.layoutInferiorScroll.constant = 0
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: CGFloat(0.90), initialSpringVelocity: CGFloat(10.0), options: UIViewAnimationOptions.allowUserInteraction, animations: { () -> Void in
                self.view.layoutIfNeeded()
                }, completion: { (finished: Bool) -> Void in
                    self.layoutEspacioScrollControles.constant = 125
                    self.layoutEspacio1.constant = 125
                    self.layoutEspacio2.constant = 125
                    self.view.layoutIfNeeded()
//                    self.btnConfiguracion.enabled = true
            })
        }
    }
    
    func addBotonConfiguracion(_ valor: CGFloat){
//        let progressView = UIProgressView(progressViewStyle: .Default)
//        progressView.sizeToFit()
//        let progressButton = UIBarButtonItem(customView: progressView)
        
//        let myBtn = botonConfiguracion(type: UIButtonType.Custom)
//        myBtn.frame = CGRectMake(0, 0, 30, 30)
//        myBtn.addTarget(self, action: "clickConfiguracion:", forControlEvents: UIControlEvents.TouchUpInside)
//        myBtn.girar = valor
        
//        let items = UIBarButtonItem(customView: boton(valor))
//        self.navigationItem.setRightBarButtonItems([items], animated: true)
    }
    
    func boton(_ valor: CGFloat) -> botonConfiguracion {
        let myBtn = botonConfiguracion(type: UIButtonType.custom)
        myBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        myBtn.addTarget(self, action: #selector(ViewControlB.clickConfiguracion(_:)), for: UIControlEvents.touchUpInside)
        myBtn.girar = valor
        myBtn.rotacion = true
        myBtn.centro = true
        myBtn.dientesEX = true
        myBtn.dientesIN = true
        myBtn.setNeedsDisplay()
        return myBtn
    }
    
    func girarA(){
        if btnConfiguracion.girar < 100 {
            btnConfiguracion.girar = btnConfiguracion.girar + 5
        } else {
            btnConfiguracion.girar = 100
        }
    }
    
    func girarB(){
        if btnConfiguracion.girar > 0 {
            btnConfiguracion.girar = btnConfiguracion.girar - 5
        } else {
            btnConfiguracion.girar = 0
        }
    }
    
    func clickConfiguracion(_ sender:botonConfiguracion!)
    {
//        sender.rotacion = true
//        sender.centro = false
//        sender.dientesEX = true
//        sender.dientesIN = true
        
        sender.isEnabled = false
        if conf {
            //Animacion
            let timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewControlB.girarB), userInfo: nil, repeats: true)
            sender.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            UIView.animate(withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: CGFloat(0.50),
                initialSpringVelocity: CGFloat(9.0),
                options: UIViewAnimationOptions.allowUserInteraction,
                animations: {
//                    sender.girar = 0
                    sender.transform = CGAffineTransform.identity
                    
                },
                completion: { (finished: Bool) -> Void in
                    self.btnConfiguracion.isEnabled = true
                    timer.invalidate()
            })
        } else {
            //Animacion
//            sender.girar = 0
            let timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewControlB.girarA), userInfo: nil, repeats: true)
            sender.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            UIView.animate(withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: CGFloat(0.50),
                initialSpringVelocity: CGFloat(9.0),
                options: UIViewAnimationOptions.allowUserInteraction,
                animations: {
//                    sender.girar = 10
                    sender.transform = CGAffineTransform.identity
                },
                completion: { (finished: Bool) -> Void in
                    self.btnConfiguracion.isEnabled = true
                    timer.invalidate()
            })
        }
        conf = !conf
        actualizarLayoutBotonConfiguracion()
        delegate.setOpcionesON(conf)
    }
    
    
    
    
    //                                              INICIO                              --------++++++====
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        btnConfiguracion.Diseño = Botones.diseño_C
        btnConfiguracion.rotacion = true
        btnConfiguracion.centro = false
        btnConfiguracion.dientesEX = true
        btnConfiguracion.dientesIN = true
        
        conf = toPassBotonConfiguracionON
        if conf {
            layoutInferiorScroll.constant = 125
            layoutEspacioScrollControles.constant = 5
            layoutEspacio1.constant = 5
            layoutEspacio2.constant = 5
//            addBotonConfiguracion(10)
//            btnConfiguracion.rotacion = true
            btnConfiguracion.girar = 100
        } else {
            layoutInferiorScroll.constant = 0
            layoutEspacioScrollControles.constant = 125
            layoutEspacio1.constant = 125
            layoutEspacio2.constant = 125
//            addBotonConfiguracion(0)
//            btnConfiguracion.rotacion = true
            btnConfiguracion.girar = 0
        }
        delegate.setOpcionesON(conf)
        
//        scrollView.contentSize.height = 1280
//        scrollView.contentSize.width = 1024
        
        switchMarco.isOn = toPassSwithMarco
        switchTextoInferior.isOn = toPassSwithTextoInferior
        
        var colorTexto: UIColor
//        var colorFondo: UIColor
        let ct = toPassColTexto.coreImageColor
//        let cf = toPassColFondo.coreImageColor
        if ct!.alpha <= CGFloat(0.3) {
            colorTexto = UIColor(red: CGFloat((ct?.red)!), green: CGFloat((ct?.green)!), blue: CGFloat((ct?.blue)!), alpha: CGFloat(0.4))
        } else {
            colorTexto = UIColor(red: CGFloat((ct?.red)!), green: CGFloat((ct?.green)!), blue: CGFloat((ct?.blue)!), alpha: CGFloat((ct?.alpha)!))
        }
//        if cf?.alpha <= CGFloat(0.3) {
//            colorFondo = UIColor(red: CGFloat((cf?.red)!), green: CGFloat((cf?.green)!), blue:CGFloat((cf?.blue)!), alpha: CGFloat(0.4))
//        } else {
//            colorFondo = UIColor(red: CGFloat((cf?.red)!), green: CGFloat((cf?.green)!), blue: CGFloat((cf?.blue)!), alpha: CGFloat((cf?.alpha)!))
//        }
        
//        switchMarco.onTintColor = colorTexto
//        switchMarco.tintColor = colorFondo
//        switchTextoInferior.onTintColor = colorTexto
//        switchTextoInferior.tintColor = colorFondo
        
        sliderTamTexto.minimumValueImage = getImageLetra(CGRect(x: 0, y: 0, width: 18, height: 20), color: colorTexto)
        sliderTamTexto.maximumValueImage = getImageLetra(CGRect(x: 0, y: 0, width: 28, height: 30), color: colorTexto)
        
//        alto.constant = scrollView.frame.height
        rect = CGRect(x: 0, y: 0, width: 1024, height: 1280) //Es el tamaño de salida de la imagen
        
        var num: CGFloat = 0 //CGFloat(sliderTamTexto.value)
        if let n = NumberFormatter().number(from: toPassTam) {
            num = CGFloat(n)
        }
        sliderTamTexto.value = Float(num)
        
        ActualizarImagen()
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        let name = "Pantalla~\(self.title!)"
        
        // The UA-XXXXX-Y tracker ID is loaded automatically from the
        // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
        // If you're copying this to an app just using Analytics, you'll
        // need to configure your tracking ID here.
        // [START screen_view_hit_swift]
//        let tracker = GAI.sharedInstance().defaultTracker
//        tracker.set(kGAIScreenName, value: name)
        
//        let builder = GAIDictionaryBuilder.createScreenView()
//        tracker.send(builder.build() as [NSObject : AnyObject])
        // [END screen_view_hit_swift]
    }
    
    
    func ActualizarImagen(){
        var num: CGFloat = 0
        if let n = NumberFormatter().number(from: toPassTam) {
            num = CGFloat(n)
        }
        
        Img.image = getImagen(toPassColFondo, frame: rect, otro: toPassColTexto, sizeText: num, numero: toPassNum, texto: toPassText, marco: switchMarco.isOn, textoInferior: switchTextoInferior.isOn)
//        Img.inputView?.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    func getImagen(_ fondo: UIColor, frame: CGRect, otro: UIColor, sizeText: CGFloat, numero: String, texto: String, marco: Bool, textoInferior: Bool) -> UIImage {
        let size = CGSize(width: frame.width, height: frame.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        dibujarImagen(frame, fondo: fondo, otro: otro, sizeText: sizeText, numero: numero, texto: texto, ocultarMarco: marco, ocultarTexto: textoInferior)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func getImageLetra(_ frame: CGRect, color: UIColor) -> UIImage {
        let size = CGSize(width: frame.width, height: frame.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        dibujarLetra(frame, otro: color)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        if error == nil {
            let ac = UIAlertController(title: "Saved", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
    
    
    
    func dibujarLetra(_ frame: CGRect, otro: UIColor) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.33)
        shadow.shadowOffset = CGSize(width: 0.6, height: 0.6)
        shadow.shadowBlurRadius = 2
        
        //// Text Drawing
        let textPath = UIBezierPath()
        textPath.move(to: CGPoint(x: frame.minX + 0.58562 * frame.width, y: frame.minY + 0.54223 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.50057 * frame.width, y: frame.minY + 0.30477 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.41018 * frame.width, y: frame.minY + 0.54223 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.58562 * frame.width, y: frame.minY + 0.54223 * frame.height))
        textPath.close()
        textPath.move(to: CGPoint(x: frame.minX + 0.46091 * frame.width, y: frame.minY + 0.22500 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.54672 * frame.width, y: frame.minY + 0.22500 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.75000 * frame.width, y: frame.minY + 0.76250 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.66686 * frame.width, y: frame.minY + 0.76250 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.61003 * frame.width, y: frame.minY + 0.60151 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.38844 * frame.width, y: frame.minY + 0.60151 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.32780 * frame.width, y: frame.minY + 0.76250 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.25000 * frame.width, y: frame.minY + 0.76250 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.46091 * frame.width, y: frame.minY + 0.22500 * frame.height))
        textPath.close()
        context?.saveGState()
        context?.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        otro.setFill()
        textPath.fill()
        context?.restoreGState()
    }
    
    func dibujarImagen(_ frame: CGRect, fondo: UIColor, otro: UIColor, sizeText: CGFloat, numero: String, texto: String, ocultarMarco: Bool, ocultarTexto: Bool) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        
        //// Variable Declarations
        let sizePinedo: CGFloat = sizeText * 1.815
        let sizePresidencia: CGFloat = sizeText * 0.9999
        let sizeEslogan: CGFloat = sizeText * 0.4444
        let sizeTexto: CGFloat = sizeText * 1.111
        
        //// FondoRecuadro Drawing
        let fondoRecuadroPath = UIBezierPath(rect: CGRect(x: frame.minX + floor(frame.width * 0.00000 + 0.5), y: frame.minY + floor(frame.height * -0.00000 + 0.5), width: floor(frame.width * 1.00000 + 0.5) - floor(frame.width * 0.00000 + 0.5), height: floor(frame.height * 1.00000 + 0.5) - floor(frame.height * -0.00000 + 0.5)))
        fondo.setFill()
        fondoRecuadroPath.fill()
        
        
        //// MsjLey Drawing
        let msjLeyRect = CGRect(x: frame.minX + floor(frame.width * 0.05000 + 0.5), y: frame.minY + floor(frame.height * 0.16000 + 0.5), width: floor(frame.width * 0.95000 + 0.5) - floor(frame.width * 0.05000 + 0.5), height: floor(frame.height * 0.72400 + 0.5) - floor(frame.height * 0.16000 + 0.5))
        let msjLeyStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        msjLeyStyle.alignment = NSTextAlignment.center
        
        let msjLeyFontAttributes = [NSFontAttributeName: UIFont(name: "Kailasa", size: sizeTexto)!, NSForegroundColorAttributeName: otro, NSParagraphStyleAttributeName: msjLeyStyle]
        
        let msjLeyTextHeight: CGFloat = NSString(string: texto).boundingRect(with: CGSize(width: msjLeyRect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: msjLeyFontAttributes, context: nil).size.height
        context?.saveGState()
        context?.clip(to: msjLeyRect);
        NSString(string: texto).draw(in: CGRect(x: msjLeyRect.minX, y: msjLeyRect.minY + (msjLeyRect.height - msjLeyTextHeight) / 2, width: msjLeyRect.width, height: msjLeyTextHeight), withAttributes: msjLeyFontAttributes)
        context?.restoreGState()
        
        
        if (ocultarTexto) {
            //// eslogan Drawing
            let esloganRect = CGRect(x: frame.minX + floor(frame.width * 0.05000 + 0.5), y: frame.minY + floor(frame.height * 0.92400 + 0.5), width: floor(frame.width * 0.95000 + 0.5) - floor(frame.width * 0.05000 + 0.5), height: floor(frame.height * 0.97400 + 0.5) - floor(frame.height * 0.92400 + 0.5))
            let esloganTextContent = NSString(string: "CORTITA PERO JUGUETONA")
            let esloganStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            esloganStyle.alignment = NSTextAlignment.center
            
            let esloganFontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: sizeEslogan), NSForegroundColorAttributeName: otro, NSParagraphStyleAttributeName: esloganStyle]
            
            let esloganTextHeight: CGFloat = esloganTextContent.boundingRect(with: CGSize(width: esloganRect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: esloganFontAttributes, context: nil).size.height
            context?.saveGState()
            context?.clip(to: esloganRect);
            esloganTextContent.draw(in: CGRect(x: esloganRect.minX, y: esloganRect.minY + (esloganRect.height - esloganTextHeight) / 2, width: esloganRect.width, height: esloganTextHeight), withAttributes: esloganFontAttributes)
            context?.restoreGState()
            
            
            //// presidencia Drawing
            let presidenciaRect = CGRect(x: frame.minX + floor(frame.width * 0.05000 + 0.5), y: frame.minY + floor(frame.height * 0.72400 + 0.5), width: floor(frame.width * 0.95000 + 0.5) - floor(frame.width * 0.05000 + 0.5), height: floor(frame.height * 0.79400 + 0.5) - floor(frame.height * 0.72400 + 0.5))
            let presidenciaTextContent = NSString(string: "PRESIDENCIA")
            let presidenciaStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            presidenciaStyle.alignment = NSTextAlignment.center
            
            let presidenciaFontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: sizePresidencia), NSForegroundColorAttributeName: otro, NSParagraphStyleAttributeName: presidenciaStyle]
            
            let presidenciaTextHeight: CGFloat = presidenciaTextContent.boundingRect(with: CGSize(width: presidenciaRect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: presidenciaFontAttributes, context: nil).size.height
            context?.saveGState()
            context?.clip(to: presidenciaRect);
            presidenciaTextContent.draw(in: CGRect(x: presidenciaRect.minX, y: presidenciaRect.minY + (presidenciaRect.height - presidenciaTextHeight) / 2, width: presidenciaRect.width, height: presidenciaTextHeight), withAttributes: presidenciaFontAttributes)
            context?.restoreGState()
            
            
            //// pinedo Drawing
            let pinedoRect = CGRect(x: frame.minX + floor(frame.width * 0.05000 + 0.5), y: frame.minY + floor(frame.height * 0.79400 + 0.5), width: floor(frame.width * 0.95000 + 0.5) - floor(frame.width * 0.05000 + 0.5), height: floor(frame.height * 0.92400 + 0.5) - floor(frame.height * 0.79400 + 0.5))
            let pinedoTextContent = NSString(string: "PINEDO")
            let pinedoStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            pinedoStyle.alignment = NSTextAlignment.center
            
            let pinedoFontAttributes = [NSFontAttributeName: UIFont(name: "GeezaPro-Bold", size: sizePinedo)!, NSForegroundColorAttributeName: otro, NSParagraphStyleAttributeName: pinedoStyle]
            
            let pinedoTextHeight: CGFloat = pinedoTextContent.boundingRect(with: CGSize(width: pinedoRect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: pinedoFontAttributes, context: nil).size.height
            context?.saveGState()
            context?.clip(to: pinedoRect);
            pinedoTextContent.draw(in: CGRect(x: pinedoRect.minX, y: pinedoRect.minY + (pinedoRect.height - pinedoTextHeight) / 2, width: pinedoRect.width, height: pinedoTextHeight), withAttributes: pinedoFontAttributes)
            context?.restoreGState()
        }
        
        
        if (ocultarMarco) {
            //// NumLey Drawing
            let numLeyRect = CGRect(x: frame.minX + floor(frame.width * 0.05000 + 0.5), y: frame.minY + floor(frame.height * 0.06000 + 0.5), width: floor(frame.width * 0.95000 + 0.5) - floor(frame.width * 0.05000 + 0.5), height: floor(frame.height * 0.16000 + 0.5) - floor(frame.height * 0.06000 + 0.5))
            let numLeyPath = UIBezierPath(rect: numLeyRect)
            otro.setFill()
            numLeyPath.fill()
            let numLeyStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            numLeyStyle.alignment = NSTextAlignment.center
            
            let numLeyFontAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Black", size: sizeText)!, NSForegroundColorAttributeName: fondo, NSParagraphStyleAttributeName: numLeyStyle]
            
            let numLeyTextHeight: CGFloat = NSString(string: numero).boundingRect(with: CGSize(width: numLeyRect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: numLeyFontAttributes, context: nil).size.height
            context?.saveGState()
            context?.clip(to: numLeyRect);
            NSString(string: numero).draw(in: CGRect(x: numLeyRect.minX, y: numLeyRect.minY + (numLeyRect.height - numLeyTextHeight) / 2, width: numLeyRect.width, height: numLeyTextHeight), withAttributes: numLeyFontAttributes)
            context?.restoreGState()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
