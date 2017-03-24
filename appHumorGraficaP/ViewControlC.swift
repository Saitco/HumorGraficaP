//
//  ViewControlC.swift
//  PINEDO
//
//  Created by Matías Correnti on 13/12/15.
//  Copyright © 2015 Correnti. All rights reserved.
//

import UIKit

class ViewControlC: UIViewController {
    
    var delegate : DestinationViewDelegado! = nil
    var toPass: String! = nil
    var toPassText: String! = nil
    var toPassTam: String! = nil
    
    @IBAction func press(_ sender: AnyObject) {
        if self.navigationController != nil {
            self.navigationController!.popToRootViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        delegate.setNumber(toPass)
        delegate.setText(toPassText)
        delegate.setTam(toPassTam)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
