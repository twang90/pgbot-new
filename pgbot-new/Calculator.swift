//
//  Calculator.swift
//  pgbot-new
//
//  Created by Tiancong Wang on 8/22/18.
//  Copyright © 2018 twang14. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerCalculator: UIViewController {

    static let limit = 3
    
    var botIdentifier : Int = -1
    var botColor : UIColor = .white
    var increment : Bool = true
    
    func setIdentifier(id: Int, color: UIColor){
        botIdentifier = id
        botColor = color
    }
    
    func setDecrement() {
        increment = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var resultDisplay: UILabel!
    
    @IBOutlet weak var warningDisplay: UILabel!
    
    func addDisplay(digit : Int) {
        if (resultDisplay.text!.count >= ViewControllerCalculator.limit) {
            warningDisplay.text = "Too many Elektros"
            return
        }
        let result:Int? = Int(resultDisplay.text!)
        
        if result! == 0 {
            resultDisplay.text = String(digit)
        }
        else {
            resultDisplay.text = String(result!*10+digit)
        }
    }
    
    func removeDisplay() {
        warningDisplay.text = ""
        if resultDisplay.text?.count == 1 {
            resultDisplay.text = "0"
        }
        else {
            resultDisplay.text?.remove(at: resultDisplay.text!.index(before: resultDisplay.text!.endIndex))
        }
    }
    
    @IBAction func pressButton(_ sender: UIButton, forEvent event: UIEvent) {
        var digit = -1
        for i in 0...9 {
            if sender.title(for: .normal) == String(i) {
                print("Press Button "+String(i))
                digit = i
            }
        }
        
        if (digit > -1) {
            addDisplay(digit: digit)
        }
        else {
            if sender.title(for: .normal) == "⌫" {
                    removeDisplay()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ViewControllerDisplay {
            let result = Int(resultDisplay.text!)
            dest.setIdentifier(id: botIdentifier, color: botColor)
            dest.changeMoneyWithCalculator(money: result!, increment: increment)
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


