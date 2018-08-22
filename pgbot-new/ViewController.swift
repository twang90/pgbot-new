//
//  ViewController.swift
//  pgbot-new
//
//  Created by Tiancong Wang on 8/22/18.
//  Copyright © 2018 twang14. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Label1.text = "Change it"
    }

    @IBOutlet weak var Label1: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

