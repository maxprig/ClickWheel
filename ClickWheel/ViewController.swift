//
//  ViewController.swift
//  ClickWheel
//
//  Created by Dirk Gerretz on 16/03/15.
//  Copyright (c) 2015 [code2app];. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var label: UILabel!
    var counter = 0

    //MARK: Action
    @IBAction func clickWheelValueChanged(sender: C2AClickWheel) {
        
        if sender.angle > counter {
            label.text = "forward \(sender.angle)"
            counter = sender.angle
        } else {
            label.text = "backward \(sender.angle)"
            counter = sender.angle
        }
    }
    
    // do NOT controll drag this methos to your button in Interface Builder
    // do NOT change this method name unless you also change it in 
    // C2AClickWheek.layoutSubviews()!!
    @IBAction func centerClicked(sender: C2AClickWheel) {

        if label.text == "Clack!" {
            label.text = "Click!"
        } else {
            label.text = "Clack!"
        }
    }

}



