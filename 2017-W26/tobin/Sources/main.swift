import Foundation

func say(time: String) -> String {
    let parts = time.components(separatedBy: ":")
    let hour = parts[0]
    let minute = parts[1]
    let ten = minute[minute.startIndex]
    let one = minute[minute.index(before: minute.endIndex)]

    let start = "It's " + convertHour(hour: hour)
    let end = " " + amPm(hour: hour)


    switch (hour, ten, one) {
        case ("12", "0", "0"): return "It's noon"
        case ("00", "0", "0"): return "It's midnight"
        case (_   , "0", "0"): return start + end
        case (_   , _  , "0"): return start + " " + convertTen(ten: ten) + end
        case (_   , "1", _  ): return start + " " + teen(minute: minute) + end
        case (_   , _  , _  ): return start + " " + convertTen(ten: ten) + " " + convertOne(one: one) + end
    }
}

func convertHour(hour: String) -> String {
    switch hour {
        case "00", "12": return "twelve"
        case "01", "13": return "one"
        case "02", "14": return "two"
        case "03", "15": return "three"
        case "04", "16": return "four"
        case "05", "17": return "five"
        case "06", "18": return "six"
        case "07", "19": return "seven"
        case "08", "20": return "eight"
        case "09", "21": return "nine"
        case "10", "22": return "ten"
        case "11", "23": return "eleven"
        case _: return "Nope"
    }
}

func convertTen(ten: Character) -> String {
    switch ten {
        case "0": return "oh"
        case "1": return "ten"
        case "2": return "twenty"
        case "3": return "thirty"
        case "4": return "forty"
        case "5": return "fifty"
        case _: return "Nope"
    }
}

func convertOne(one: Character) -> String {
    switch one {
        case "1": return "one"
        case "2": return "two"
        case "3": return "three"
        case "4": return "four"
        case "5": return "five"
        case "6": return "six"
        case "7": return "seven"
        case "8": return "eight"
        case "9": return "nine"
        case _: return "Nope"
    }
}

func teen(minute: String) -> String {
    switch minute {
        case "11": return "eleven"
        case "12": return "twelve"
        case "13": return "thirteen"
        case "14": return "fourteen"
        case "15": return "fifteen"
        case "16": return "sixteen"
        case "17": return "seventeen"
        case "18": return "eighteen"
        case "19": return "nineteen"
        case _: return "Nope"
    }
}

func amPm(hour: String) -> String {
    switch hour {
        case "00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11": return "am"
        case "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23": return "pm"
        case _: return "Nope"
    }
}


print(say(time: "12:00"))
print(say(time: "00:00"))
print(say(time: "01:30"))
print(say(time: "12:05"))
print(say(time: "14:01"))
print(say(time: "20:29"))
print(say(time: "21:00"))