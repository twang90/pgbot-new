//
//  ViewController.swift
//  pgbot-new
//
//  Created by Tiancong Wang on 8/22/18.
//  Copyright © 2018 twang14. All rights reserved.
//

import UIKit

class ViewControllerButtons: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class ViewControllerDisplay: UIViewController {
    static var displayed = false
    static var bots : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (!ViewControllerDisplay.displayed){
            ViewControllerDisplay.bots = newBot()
            ViewControllerDisplay.displayed = true
        }
        for i in 0...4 {
            TextBox[i].text = ViewControllerDisplay.bots[i]
        }
    }
    
    @IBOutlet var TextBox: [UITextView]!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func random(_ n:Int) -> Int
    {
        return Int(arc4random_uniform(UInt32(n)))
    }
    
    func newBot() -> [String] {
        let pha1 = ["Last Choice","Random Choice","Early Choice for All","Player's Choice","Bidding Choice","Deciding Choice"]
        let pha2 = ["Using Cheapest Resources\n(Maximum Bid: Minimum Bid + 5 Elektro)","Buys the First Choice for Minimum Bid","Supplying Most Cities\n(Maximum Bid: Minimum Bid + 10 Elektro)","Highest Number\n(Maximum Bid: Minimum Bid + # of Own Cities)","Second Smallest Number\n(Maximum Bid: Minimum Bid)","All Power Plants\n(Maximum Bid: Minimum Bid + 1 Elektro)"]
        let pha3 = ["Normal Production and Less Than 5 Elektro", "All Resources","(Last)All Resources,\nOtherwise Normal Production","Normal Production","Normal Production and Least Available Resources","Odd Turn: Normal Production,\nEven Turn: All Resources"]
        let pha4 = ["Last Player Chooses\n(Cannot Build Through Possible Cities)","All Cities\n(Never More Than First Player)","Only Supplied Cities","Step 1: All Cities, Less Than 7;\nOtherwise: All Cities Never to First Player","Step 1: 1 City, Step 2: 2 Cities, Step 3: 3 Cities","All Cities"]
        let SA = ["Game Start: Gets 100 Elektro","Phase 1: Always Last in Player Order", "Phase 2: Pays Half Bid For Power Plants","Phase 4: All Cities Cost 10 Elektro","Phase 4: Always Builds First City For 0 Elektro","Phase 5: Gets Income for +1 City"]
        
        let ret = [pha1[random(6)],pha2[random(6)],pha3[random(6)],pha4[random(6)],SA[random(6)]]
        return ret
    }
}

