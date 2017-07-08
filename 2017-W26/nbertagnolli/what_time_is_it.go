// This file holds the solution for the what time is it programming problem
// It provides methods for converting a string in 24 hour time format into
// a twelve hour word based time format.  For example 14:45 would return
// "It's two forty five pm"

package main

import "fmt"
import "strings"
import "strconv"

func main() {
    fmt.Println(timeConversion("00:00"))
    fmt.Println(timeConversion("01:30"))
    fmt.Println(timeConversion("12:05"))
    fmt.Println(timeConversion("14:45"))
}

// adjustTime takes in a 24 hour time string and converts it to a 12 hour string
func adjustTime(time string) string {
    n, _ := strconv.Atoi(time)
    n = n -12
    if (n < 10) {
        s := strconv.Itoa(n)
        return "0" + s
    } else {
        s := strconv.Itoa(n)
        return "1" + s
    }
}

// timeConversion converts  24 hour time string of the form 00:00 into a 12 hour
// time string in words.
func timeConversion(time string) string {
    // Define the holder string
    var converted_time string = "It's "

    // split string based on colon
    var split_string []string = strings.Split(time, ":")
    fmt.Println(split_string)

    // Define an hour map from input string to output string
    digit_map := map[string]string{
        "00": "",
        "01": "one ",
        "02": "two ",
        "03": "three ",
        "04": "four ",
        "05": "five ",
        "06": "six ",
        "07": "seven ",
        "08": "eight ",
        "09": "nine ",
        "10": "ten ",
        "11": "eleven ",
        "12": "twelve ",
        "13": "thirteen ",
        "14": "fourteen ",
        "15": "fifteen ",
        "16": "sixteen ",
        "17": "seventeen ",
        "18": "eightteen ",
        "19": "nineteen ",
    }

    tens_map := map[string]string{
        "2": "twenty ",
        "3": "thirty ",
        "4": "fourty ",
        "5": "fifty ",
    }

    // Perform hour mapping
    if (split_string[0] <= "12") {
        converted_time += digit_map[split_string[0]]
    } else {
        converted_time += digit_map[adjustTime(split_string[0])]
    }

    // Perform Minute mapping
    if (split_string[1] < "20") {
        converted_time += digit_map[split_string[1]]
    } else {
        converted_time += tens_map[string(split_string[1][0])]
        converted_time += digit_map["0" + string(split_string[1][1])]
    }

    // Add am pm designation
    if (split_string[0] < "12") {
        converted_time += "am"
    } else {
        converted_time += "pm"
    }

    return converted_time
}
