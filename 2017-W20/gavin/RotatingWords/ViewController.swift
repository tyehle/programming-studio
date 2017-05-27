//
//  ViewController.swift
//  RotatingWords
//
//  Created by Gavin Yehle on 5/22/17.
//  Copyright © 2017 Gavin Yehle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var wordRotator = rotateWord()
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func goButton(_ sender: Any) {
        if let word = textField.text {
            wordRotator.setWord(word)
            let finalWord = wordRotator.performWordRotation()
            resultLabel.text = String(wordRotator.substringSize) + " " + finalWord
        }
    }

}

