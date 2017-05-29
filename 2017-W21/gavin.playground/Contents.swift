//: Playground - noun: a place where people can play

import UIKit

var totalCost = 0
let testString = "BC BC BC BC BC OH"
var str: NSString?
var key: String

var ohCount = 0
var bcCount = 0
var skCount = 0

let space = CharacterSet(charactersIn: " ")
var scanner = Scanner(string: testString)
scanner.charactersToBeSkipped = space
while scanner.scanUpToCharacters(from: space, into: &str) {
    key = str! as String
    print(key, terminator: " ")
    switch key {
    case "OH":
        ohCount += 1
        if ohCount % 3 != 0 {
            totalCost += 300
        }
    case "SK":
        skCount += 1
        totalCost += 30
    case "BC":
        bcCount += 1
        totalCost += 110
    default:
        break
    }
    print("t \(totalCost)")
}

var test: Bool = (skCount != 0) && (ohCount != 0)
while test {
    totalCost -= 30
    skCount -= 1
    ohCount -= 1
    test = (skCount != 0) && (ohCount != 0)
}
print(totalCost)


if bcCount > 4 {
    totalCost -= 20*bcCount
}
print(totalCost)



