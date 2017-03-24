//
//  ViewControlA.swift
//  PINEDO
//
//  Created by Matías Correnti on 13/12/15.
//  Copyright © 2015 Correnti. All rights reserved.
//

import UIKit
//import Google

protocol DestinationViewDelegado {
    func setNumber(_ number: String)
    func setText(_ texto: String)
    func setTam(_ tam: String)
    func setColorFondo(_ color: UIColor)
    func setColorTexto(_ color: UIColor)
    func setMarcoBool(_ on: Bool)
    func setTextoInferiorBool(_ on: Bool)
    func setOpcionesON(_ on: Bool)
}

class ViewControlA: UIViewController, UITextFieldDelegate,  DestinationViewDelegado {
    
    fileprivate struct Cache {
        static var colorFondo: UIColor = UIColor(red: 0.992, green: 0.784, blue: 0.180, alpha: 1.000)
        static var colorLetras: UIColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        static var myDefault: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.500)
    }
    
    func getColorFondo() -> UIColor {
        return colorFondoV == nil ? Cache.colorFondo : colorFondoV
    }
    
    func getColorTexto() -> UIColor {
        return colorTextoV == nil ? Cache.colorLetras : colorTextoV
    }
    
    var marco: Bool! = nil
    var textoInferior: Bool! = nil
    var tamanioTexto: String! = nil
    var colorFondoV: UIColor! = nil
    var colorTextoV: UIColor! = nil
    var opcionesON: Bool! = nil
    
    @IBOutlet var scrollViewG: UIScrollView!
    @IBOutlet weak var numeroLey: UITextField!
    @IBOutlet weak var textoley: UITextView!
    
    @IBOutlet var SegmenSelect: UISegmentedControl!
    @IBOutlet var MuestraColor: UIImageView!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.textoley.layer.cornerRadius = 5
        self.textoley.layer.needsDisplayOnBoundsChange = true
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
        ActualizarValoresControles(SegmenSelect.selectedSegmentIndex)
    }
    
    @IBAction func botonVisualizar(_ sender: AnyObject) {
//        sender.transform = CGAffineTransformMakeScale(0.6, 0.8)
//        
//        UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: CGFloat(0.20), initialSpringVelocity: CGFloat(6.0), options: UIViewAnimationOptions.AllowUserInteraction, animations: { sender.transform = CGAffineTransformIdentity
//            }, completion: { Void in() })
    }
    
    @IBAction func tapTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if ((userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
//                let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
//                if alto.constant < keyboardSize.height + 10 {
//                    alto.constant = keyboardSize.height + 10
//                }
                scrollViewG.scrollRectToVisible(CGRect(x: 0, y: 0, width: 50, height: 100), animated: true)

            } else {
                // no UIKeyboardFrameBeginUserInfoKey entry in userInfo
            }
        } else {
            // no userInfo dictionary in notification
        }
    }
    
    func keyboardWillHide(_ sender: Notification) {

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        resignFirstResponder()
        self.scrollViewG.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "datos") {
            let destination = segue.destination as! ViewControlB
            destination.delegate = self
            destination.toPassNum = numeroLey.text
            destination.toPassText = textoley.text
            destination.toPassTam = tamanioTexto == nil ? "73" : tamanioTexto
            destination.toPassColFondo = colorFondoV == nil ? UIColor(red: 0.9919, green: 0.7839, blue: 0.1800, alpha: 1.0) : colorFondoV
            destination.toPassColTexto = colorTextoV == nil ? UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0) : colorTextoV
            destination.toPassSwithMarco = marco == nil ? true : marco
            destination.toPassSwithTextoInferior = textoInferior == nil ? true : textoInferior
            destination.toPassBotonConfiguracionON = opcionesON == nil ? false : opcionesON
        } else if (segue.identifier == "color") {
            let destination = segue.destination as! ViewControlColor
            destination.delegate = self
            destination.toPassColFondo = colorFondoV == nil ? UIColor(red: 0.9919, green: 0.7839, blue: 0.1800, alpha: 1.0) : colorFondoV
            destination.toPassColTexto = colorTextoV == nil ? UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0) : colorTextoV
        } else if (segue.identifier == "color2") {
//            let nav = segue.destinationViewController as! UINavigationController
//            let destination = nav.topViewController as! UITableControl
//            destination.delegate = self
//            destination.toPassColFondo = colorFondoV
//            destination.toPassColTexto = colorTextoV
            
//            let destination = segue.destinationViewController as! ViewControlColorTexto
//            destination.delegate = self
//            destination.toPassColTexto = colorTextoV
        } else {
            print("Unknown segue")
        }
    }
    
    func setNumber(_ number: String) {
        numeroLey.text = number
    }
    
    func setText(_ texto: String) {
        textoley.text = texto
    }
    
    func setTam(_ tam: String) {
//        colTextoV.text = tam
        tamanioTexto = tam
//        if let n = NSNumberFormatter().numberFromString(tam) {
//            steppTamTex.value = Double(n)
//        }
    }
    
    func setColorFondo(_ color: UIColor) {
        colorFondoV = color
        displayMuestraColor()
    }
    
    func setColorTexto(_ color: UIColor) {
        colorTextoV = color
        displayMuestraColor()
    }
    
    func setMarcoBool(_ on: Bool) {
        marco = on
    }
    
    func setTextoInferiorBool(_ on: Bool) {
        textoInferior = on
    }
    
    func setOpcionesON(_ on: Bool) {
        opcionesON = on
    }
    
    
    
    
    
    func displayMuestraColor() {
        DispatchQueue.main.async(execute: {
            self.MuestraColor.image = self.getImageMuestra(CGRect(x: 0, y: 0, width: 350, height: 50), fondo: self.getColorFondo(), texto: self.getColorTexto())
            return
        })
    }
    
    func getImageMuestra(_ frame: CGRect, fondo: UIColor, texto: UIColor) -> UIImage {
        let size = CGSize(width: frame.width, height: frame.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        dibujarCuadro(frame, fondo: fondo, otro: texto)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func ActualizarValoresControles(_ valor: Int) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        var myColor: UIColor! = nil
        
        switch valor {
        case 0:
            myColor = getColorFondo()
            break
        case 1:
            myColor = getColorTexto()
            break
        default:
            myColor = Cache.myDefault
            break
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
        GuardarColor()
    }
    
    func GuardarColor(){
        let red = CGFloat(setColorR.value)
        let green = CGFloat(setColorG.value)
        let blue = CGFloat(setColorB.value)
        let alpha = CGFloat(setValorA.value)
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
        switch SegmenSelect.selectedSegmentIndex {
        case 0:
            setColorFondo(color)
            break
        case 1:
            setColorTexto(color)
            break
        default:
            setColorFondo(color)
            setColorTexto(color)
            break
        }
    }
    
    
    
    
    
    
    
    func dibujarCuadro(_ frame: CGRect, fondo: UIColor, otro: UIColor) {
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: frame.minX + floor(frame.width * 0.00000 + 0.5), y: frame.minY + floor(frame.height * 0.00000 + 0.5), width: floor(frame.width * 1.00000 + 0.5) - floor(frame.width * 0.00000 + 0.5), height: floor(frame.height * 1.00000 + 0.5) - floor(frame.height * 0.00000 + 0.5)))
        fondo.setFill()
        rectanglePath.fill()
        
        
        //// Text Drawing
        let textPath = UIBezierPath()
        textPath.move(to: CGPoint(x: frame.minX + 0.10161 * frame.width, y: frame.minY + 0.80952 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.10161 * frame.width, y: frame.minY + 0.19048 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.15515 * frame.width, y: frame.minY + 0.19048 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.19515 * frame.width, y: frame.minY + 0.22833 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.17383 * frame.width, y: frame.minY + 0.19048 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.18716 * frame.width, y: frame.minY + 0.20309 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.20714 * frame.width, y: frame.minY + 0.35486 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.20314 * frame.width, y: frame.minY + 0.25357 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.20714 * frame.width, y: frame.minY + 0.29574 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.19111 * frame.width, y: frame.minY + 0.51108 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.20714 * frame.width, y: frame.minY + 0.42178 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.20179 * frame.width, y: frame.minY + 0.47386 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.14623 * frame.width, y: frame.minY + 0.56692 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.18042 * frame.width, y: frame.minY + 0.54831 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.16546 * frame.width, y: frame.minY + 0.56692 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.13295 * frame.width, y: frame.minY + 0.56692 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.13295 * frame.width, y: frame.minY + 0.80952 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.10161 * frame.width, y: frame.minY + 0.80952 * frame.height))
        textPath.close()
        textPath.move(to: CGPoint(x: frame.minX + 0.13295 * frame.width, y: frame.minY + 0.48201 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.13918 * frame.width, y: frame.minY + 0.48201 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.16506 * frame.width, y: frame.minY + 0.45127 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.15010 * frame.width, y: frame.minY + 0.48201 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.15873 * frame.width, y: frame.minY + 0.47177 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.17456 * frame.width, y: frame.minY + 0.36782 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.17139 * frame.width, y: frame.minY + 0.43078 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.17456 * frame.width, y: frame.minY + 0.40296 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.14540 * frame.width, y: frame.minY + 0.27539 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.17456 * frame.width, y: frame.minY + 0.30620 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.16484 * frame.width, y: frame.minY + 0.27539 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.13295 * frame.width, y: frame.minY + 0.27539 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.13295 * frame.width, y: frame.minY + 0.48201 * frame.height))
        textPath.close()
        textPath.move(to: CGPoint(x: frame.minX + 0.23194 * frame.width, y: frame.minY + 0.80952 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.23194 * frame.width, y: frame.minY + 0.19048 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.26389 * frame.width, y: frame.minY + 0.19048 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.26389 * frame.width, y: frame.minY + 0.80952 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.23194 * frame.width, y: frame.minY + 0.80952 * frame.height))
        textPath.close()
        textPath.move(to: CGPoint(x: frame.minX + 0.30239 * frame.width, y: frame.minY + 0.80952 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.30239 * frame.width, y: frame.minY + 0.19048 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.33051 * frame.width, y: frame.minY + 0.19048 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.40169 * frame.width, y: frame.minY + 0.61335 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.40169 * frame.width, y: frame.minY + 0.19048 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.42732 * frame.width, y: frame.minY + 0.19048 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.42732 * frame.width, y: frame.minY + 0.80952 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.39868 * frame.width, y: frame.minY + 0.80952 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.32802 * frame.width, y: frame.minY + 0.38665 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.32802 * frame.width, y: frame.minY + 0.80952 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.30239 * frame.width, y: frame.minY + 0.80952 * frame.height))
        textPath.close()
        textPath.move(to: CGPoint(x: frame.minX + 0.46571 * frame.width, y: frame.minY + 0.80952 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.46571 * frame.width, y: frame.minY + 0.19048 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.56169 * frame.width, y: frame.minY + 0.19048 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.56169 * frame.width, y: frame.minY + 0.27539 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.49767 * frame.width, y: frame.minY + 0.27539 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.49767 * frame.width, y: frame.minY + 0.44813 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.55017 * frame.width, y: frame.minY + 0.44813 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.55017 * frame.width, y: frame.minY + 0.53095 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.49767 * frame.width, y: frame.minY + 0.53095 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.49767 * frame.width, y: frame.minY + 0.72169 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.56656 * frame.width, y: frame.minY + 0.72169 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.56656 * frame.width, y: frame.minY + 0.80952 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.46571 * frame.width, y: frame.minY + 0.80952 * frame.height))
        textPath.close()
        textPath.move(to: CGPoint(x: frame.minX + 0.59333 * frame.width, y: frame.minY + 0.80952 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.59333 * frame.width, y: frame.minY + 0.19048 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.65943 * frame.width, y: frame.minY + 0.19048 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.71411 * frame.width, y: frame.minY + 0.26681 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.68322 * frame.width, y: frame.minY + 0.19048 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.70145 * frame.width, y: frame.minY + 0.21592 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.73310 * frame.width, y: frame.minY + 0.48703 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.72677 * frame.width, y: frame.minY + 0.31770 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.73310 * frame.width, y: frame.minY + 0.39111 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.71297 * frame.width, y: frame.minY + 0.72482 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.73310 * frame.width, y: frame.minY + 0.58909 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.72639 * frame.width, y: frame.minY + 0.66836 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.65663 * frame.width, y: frame.minY + 0.80952 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.69955 * frame.width, y: frame.minY + 0.78129 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.68077 * frame.width, y: frame.minY + 0.80952 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.59333 * frame.width, y: frame.minY + 0.80952 * frame.height))
        textPath.close()
        textPath.move(to: CGPoint(x: frame.minX + 0.62529 * frame.width, y: frame.minY + 0.72169 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.64915 * frame.width, y: frame.minY + 0.72169 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.68677 * frame.width, y: frame.minY + 0.66543 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.66596 * frame.width, y: frame.minY + 0.72169 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.67850 * frame.width, y: frame.minY + 0.70293 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.69917 * frame.width, y: frame.minY + 0.49456 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.69503 * frame.width, y: frame.minY + 0.62792 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.69917 * frame.width, y: frame.minY + 0.57097 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.68921 * frame.width, y: frame.minY + 0.34691 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.69917 * frame.width, y: frame.minY + 0.43545 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.69585 * frame.width, y: frame.minY + 0.38623 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.67271 * frame.width, y: frame.minY + 0.29086 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.68464 * frame.width, y: frame.minY + 0.31986 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.67914 * frame.width, y: frame.minY + 0.30118 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.64459 * frame.width, y: frame.minY + 0.27539 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.66627 * frame.width, y: frame.minY + 0.28054 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.65690 * frame.width, y: frame.minY + 0.27539 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.62529 * frame.width, y: frame.minY + 0.27539 * frame.height))
        textPath.addLine(to: CGPoint(x: frame.minX + 0.62529 * frame.width, y: frame.minY + 0.72169 * frame.height))
        textPath.close()
        textPath.move(to: CGPoint(x: frame.minX + 0.82918 * frame.width, y: frame.minY + 0.82500 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.77325 * frame.width, y: frame.minY + 0.73633 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.80587 * frame.width, y: frame.minY + 0.82500 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.78722 * frame.width, y: frame.minY + 0.79544 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.75229 * frame.width, y: frame.minY + 0.50000 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.75928 * frame.width, y: frame.minY + 0.67721 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.75229 * frame.width, y: frame.minY + 0.59843 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.77336 * frame.width, y: frame.minY + 0.26284 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.75229 * frame.width, y: frame.minY + 0.40045 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.75931 * frame.width, y: frame.minY + 0.32140 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.83022 * frame.width, y: frame.minY + 0.17500 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.78740 * frame.width, y: frame.minY + 0.20428 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.80635 * frame.width, y: frame.minY + 0.17500 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.88692 * frame.width, y: frame.minY + 0.26284 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.85394 * frame.width, y: frame.minY + 0.17500 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.87284 * frame.width, y: frame.minY + 0.20428 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.90804 * frame.width, y: frame.minY + 0.49875 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.90100 * frame.width, y: frame.minY + 0.32140 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.90804 * frame.width, y: frame.minY + 0.40003 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.88692 * frame.width, y: frame.minY + 0.73758 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.90804 * frame.width, y: frame.minY + 0.59969 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.90100 * frame.width, y: frame.minY + 0.67930 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.82918 * frame.width, y: frame.minY + 0.82500 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.87284 * frame.width, y: frame.minY + 0.79586 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.85360 * frame.width, y: frame.minY + 0.82500 * frame.height))
        textPath.close()
        textPath.move(to: CGPoint(x: frame.minX + 0.82959 * frame.width, y: frame.minY + 0.73967 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.86212 * frame.width, y: frame.minY + 0.67463 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.84329 * frame.width, y: frame.minY + 0.73967 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.85413 * frame.width, y: frame.minY + 0.71799 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.87411 * frame.width, y: frame.minY + 0.49833 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.87011 * frame.width, y: frame.minY + 0.63127 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.87411 * frame.width, y: frame.minY + 0.57250 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.86207 * frame.width, y: frame.minY + 0.32516 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.87411 * frame.width, y: frame.minY + 0.42638 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.87009 * frame.width, y: frame.minY + 0.36866 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.83022 * frame.width, y: frame.minY + 0.25991 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.85405 * frame.width, y: frame.minY + 0.28166 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.84343 * frame.width, y: frame.minY + 0.25991 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.79821 * frame.width, y: frame.minY + 0.32516 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.81686 * frame.width, y: frame.minY + 0.25991 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.80620 * frame.width, y: frame.minY + 0.28166 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.78622 * frame.width, y: frame.minY + 0.49958 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.79022 * frame.width, y: frame.minY + 0.36866 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.78622 * frame.width, y: frame.minY + 0.42680 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.79815 * frame.width, y: frame.minY + 0.67379 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.78622 * frame.width, y: frame.minY + 0.57180 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.79020 * frame.width, y: frame.minY + 0.62987 * frame.height))
        textPath.addCurve(to: CGPoint(x: frame.minX + 0.82959 * frame.width, y: frame.minY + 0.73967 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.80611 * frame.width, y: frame.minY + 0.71771 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.81659 * frame.width, y: frame.minY + 0.73967 * frame.height))
        textPath.close()
        otro.setFill()
        textPath.fill()
    }
}
