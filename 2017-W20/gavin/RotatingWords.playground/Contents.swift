//: Playground - noun: a place where people can play

var word = "onion"
var rotatedWord = word
var bestWord = word
var substringSize = 0
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

print("\(substringSize) \(bestWord)")





var wordArray = Array(word.characters)
rotatedWord = word
bestWord = word
substringSize = 0

for index in wordArray.indices {
    if index != wordArray.count {
        wordArray.append(wordArray.remove(at: 0))
        rotatedWord = String(wordArray)
    }
    if rotatedWord < bestWord {
        bestWord = rotatedWord
        substringSize = index + 1
    }
}

print("\(substringSize) \(bestWord)")