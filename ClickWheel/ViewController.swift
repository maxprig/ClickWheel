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

    //MARK: Action
    @IBAction func clickWheelValueChanged(sender: C2AClickWheel) {
        
        label.text = "\(sender.counter)"

    }
    @IBAction func centerClicked(sender: C2AClickWheel) {

        if label.text == "Clack!" {
            label.text = "Click!"
        } else {
            label.text = "Clack!"
        }
    }

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}



