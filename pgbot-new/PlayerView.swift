//
//  PlayerView.swift
//  pgbot-new
//
//  Created by Tiancong Wang on 8/23/18.
//  Copyright © 2018 twang14. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerHumanDisplay: UIViewController {
    var identifier : Int = -1
    var color : UIColor = .white
    
    func setIdentifier(id: Int, color: UIColor){
        identifier = id
        self.color = color
    }

    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var moneyDisplay: UIButton!
    
    @IBOutlet weak var moneyControl: UISegmentedControl!
    
    @IBOutlet weak var moneyInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print ("In human "+String(identifier))
        assert(identifier != -1 && players.count > identifier)
        
        assert(!(players[identifier] is PGBot))
        
        titleLabel.text = "Player "+String(identifier+1)
        titleLabel.backgroundColor = color
        moneyDisplay.setTitle("Hold to\nsee your Elektro", for: .normal)
        moneyDisplay.layer.borderWidth = 3
    }
    
    
    @IBAction func showMoneyStart(_ sender: UIButton, forEvent event: UIEvent) {
        moneyDisplay.setTitle(String(players[identifier].money), for: .normal)
    }
    @IBAction func showMoney(_ sender: UIButton, forEvent event: UIEvent) {
        moneyDisplay.setTitle("Hold to\nsee your Elektro", for: .normal)
    }

    @IBAction func doneEditing(_ sender: Any) {
        self.view.endEditing(true);
    }
    @IBAction func changeMoney(_ sender: UIButton) {
        let result = Int(moneyInput.text!)!
        if (sender.title(for: .normal) == "Earn") {
            players[identifier].money += result
        }
        else if (sender.title(for: .normal) == "Spend") {
            players[identifier].money -= result
        }
        self.view.endEditing(true);
        moneyInput.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(players)
    }
}
