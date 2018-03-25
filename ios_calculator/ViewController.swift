//
//  ViewController.swift
//  ios_calculator
//
//  Created by v.laptev on 24.03.2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var resultLabel: UILabel!
    
    var isStartTyping = true;
    
    @IBAction func pressNumber(_ sender: UIButton) {
        let number = sender.currentTitle!;
        let currentText = resultLabel.text ?? ""
        
        if (number == "<––") {
            if (currentText == "" || currentText.count == 1) {
                resultLabel.text = "0"
                isStartTyping = true
            } else {
                resultLabel.text = String (currentText.dropLast())
            }
            return;
        }
        
        if (currentText.count < 25) {
            if (isStartTyping) {
                resultLabel.text = number
                isStartTyping = false;
            } else {
                resultLabel.text = resultLabel.text! + number
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

