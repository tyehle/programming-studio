//
//  rotateWord.swift
//  RotatingWords
//
//  Created by Gavin Yehle on 5/22/17.
//  Copyright © 2017 Gavin Yehle. All rights reserved.
//

import Foundation

class rotateWord {
    
    private var word = ""
    private var rotatedWord = ""
    private var bestWord = ""
    public var substringSize = 0
    
    func setWord (_ passedWord: String) {
        word = passedWord
    }
    
    func performWordRotation() -> String {
        rotatedWord = word
        bestWord = word
        var i = 1
        for index in word.characters.indices {
            if index != word.endIndex {
                rotatedWord.append(rotatedWord.remove(at: rotatedWord.startIndex))
            }
            if rotatedWord < bestWord {
                bestWord = rotatedWord
                substringSize = i
            }
            i += 1
        }
        
        return bestWord
    }
}
