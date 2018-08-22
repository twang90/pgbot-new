//
//  ViewController.swift
//  pgbot-new
//
//  Created by Tiancong Wang on 8/22/18.
//  Copyright © 2018 twang14. All rights reserved.
//

import UIKit

let maxBots = 6
var bots : [[String]] = Array(repeating: [], count: maxBots)

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

class ViewControllerButtons: UIViewController {
    
    static var buttonStorage : [UIButton] = []
    static var colorButtonStorage : [UIButton] = []
    
    var colorButtonLoc : [CGPoint] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Save original location of the button
        for i in 0...colorButtons.count-1 {
            colorButtonLoc.append(colorButtons[i].center)
        }
        
        // Restore previous storage
        if (ViewControllerButtons.buttonStorage.count != 0) {
            for i in 0...ViewControllerButtons.buttonStorage.count-1 {
                buttons[i].backgroundColor = ViewControllerButtons.buttonStorage[i].backgroundColor
                buttons[i].setTitle(ViewControllerButtons.buttonStorage[i].title(for: .normal), for: .normal)
                buttons[i].setTitleColor(ViewControllerButtons.buttonStorage[i].titleColor(for: .normal), for: .normal)
                
            }
            ViewControllerButtons.buttonStorage.removeAll(keepingCapacity: false)
        }
        if (ViewControllerButtons.colorButtonStorage.count != 0) {
            for i in 0...ViewControllerButtons.colorButtonStorage.count-1 {
                colorButtons[i].alpha = ViewControllerButtons.colorButtonStorage[i].alpha
                colorButtons[i].isEnabled = ViewControllerButtons.colorButtonStorage[i].isEnabled
            }
            ViewControllerButtons.colorButtonStorage.removeAll(keepingCapacity: false)
        }
        
        // Don't allow users to click a button, if it's not painted
        for b in buttons {
            if b.backgroundColor == nil || b.backgroundColor == .white {
                b.isEnabled = false
                b.setTitleColor(.lightGray, for: .normal)
            }
        }
    }
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet var colorButtons: [UIButton]!
    
    @IBAction func dragButton(_ sender: UIButton, forEvent event: UIEvent) {
        if let center = event.allTouches?.first?.location(in: self.view) {
            sender.center = center
        }
    }
    
    
    @IBAction func releaseButton(_ sender: UIButton, forEvent event: UIEvent) {
        for i in 0...maxBots-1 {
            if (buttons[i].frame.intersects(sender.frame)){
                // disable the button and change color
                sender.center = colorButtonLoc[colorButtons.index(of: sender)!]
                sender.alpha = 0.2
                sender.isEnabled = false

                // Generate a bot and paint it
                bots[i] = newBot()
                buttons[i].setTitle("Bot "+String(i+1), for: .normal)
                buttons[i].setTitleColor(.white, for: .normal)
                if (buttons[i].backgroundColor == nil) {
                    // Paint the button if never painted before
                    buttons[i].backgroundColor = sender.backgroundColor
                    buttons[i].isEnabled = true
                }
                else {
                    // Re-paint the bot and restore the old color
                    for b in colorButtons {
                        if (b.backgroundColor == buttons[i].backgroundColor) {
                            assert(b.isEnabled == false)
                            b.alpha = 1
                            b.isEnabled = true
                            break
                        }
                    }
                    buttons[i].backgroundColor = sender.backgroundColor
                }
                
                break
            }
        }
    }
    
    @IBAction func resetBots(_ sender: UIButton) {
        print("touch up")
        print(buttons.count)
        for i in 0...buttons.count-1 {
            buttons[i].setTitle("Empty", for: .normal)
            buttons[i].setTitleColor(.lightGray, for: .normal)
            buttons[i].isEnabled = false
            buttons[i].backgroundColor = nil
        }
        
        for i in 0...colorButtons.count-1 {
            colorButtons[i].isEnabled = true
            colorButtons[i].alpha = 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender_button = sender as? UIButton {
            if let dest = segue.destination as? ViewControllerDisplay {
                for i in 0...maxBots-1 {
                    if (segue.identifier == "ToBot"+String(i)){
                        print ("To Bot "+String(i))
                        dest.setIdentifier(id: i, color: sender_button.backgroundColor!)
                    }
                }
                
                // Save the status
                for i in 0...buttons.count-1 {
                    ViewControllerButtons.buttonStorage.append(buttons[i])
                }
                for i in 0...colorButtons.count-1 {
                    ViewControllerButtons.colorButtonStorage.append(colorButtons[i])
                }
                return
            }
        }
        assert(false)
    }
}

class ViewControllerDisplay: UIViewController {
    var botIdentifier : Int = -1
    var botColor : UIColor = .white
    func setIdentifier(id: Int, color: UIColor) {
        botIdentifier = id
        botColor = color
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print ("In bot "+String(botIdentifier))
        assert(botIdentifier != -1 && bots.count > botIdentifier)
        
        // Display the title
        titleLabel.text = "Bot "+String(botIdentifier+1)
        titleLabel.backgroundColor = botColor
        // Display the bot
        for i in 0...4 {
            TextBox[i].text = bots[botIdentifier][i]
        }
    }
    
    @IBOutlet var TextBox: [UITextView]!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

