//: Playground - noun: a place where people can play

import UIKit

var totalCost = 0

var options: Dictionary<String, Int> = [
    "OH" : 300,
    "BC" : 110,
    "SK" : 30
]
var ohCount = 0
var bcCount = 0
var skCount = 0

func addItem(_ key: String) -> Int {
    switch key {
    case "OH":
        totalCost += 300
        ohCount += 1
    case "BC":
        totalCost += 110
        bcCount += 1
    case "SK":
        totalCost += 30
        skCount += 1
    default:
        break
    }
    print(totalCost)
    return totalCost
}

func skyTourDiscount() -> Int {
    if ohCount != 0 && skCount != 0 {
        totalCost -= 30
        skCount -= 1
        print("sky tour discount \(totalCost+30) - 30 = \(totalCost)")
        skyTourDiscount()
    }
    return totalCost
}

func operaHouseDiscount() -> Int {
    if ohCount >= 3 {
        totalCost -= 300
        ohCount -= 3
        print("opera house discount \(totalCost+300) - 300 = \(totalCost)")
        operaHouseDiscount()
    }
    return totalCost
}

func bridgeClimbDiscount() -> Int {
    if bcCount >= 4 {
        let discount = 20 * bcCount
        totalCost -= discount
        bcCount -= 4
        print("bridge climb discount \(totalCost+discount) - \(discount) = \(totalCost)")
        bridgeClimbDiscount()
    }
    return totalCost
}






addItem("OH")
addItem("OH")
addItem("OH")
addItem("BC")
addItem("BC")
addItem("BC")
addItem("BC")
addItem("BC")
skyTourDiscount()
operaHouseDiscount()
bridgeClimbDiscount()
