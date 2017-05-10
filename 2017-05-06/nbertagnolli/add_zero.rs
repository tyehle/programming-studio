/// This File takes in a list of integers separated by commas and determines if the sum
/// of two integers in the list is zero.  The full problem description  can be found
/// here https://redd.it/68oda5
///
/// Author: Nicolas Bertagnolli
/// Date: 2017-05-07


// Import necessary libraries
use std::io;
use std::collections::HashMap;


fn main() {
    println!("Enter a list and we will see if two numbers add to 0");
   
    // Create a holder for the raw input 
    let mut raw_input = String::new();

    // Read from standard in
    io::stdin()
        .read_line(&mut raw_input)
        .expect("Failed to read line");

    // print out the input that was entered
    println!("You entered:  {}", raw_input);

    // Create a hashmap of the integer values
    let int_map = string_to_map(raw_input);
    
    // print out whether or not two elements add to 0
    let answer = sum_to_zero(int_map);
    println!("{}", answer);
}


/// Converts a string of integers to a hashmap
///
/// # Args
/// s: String of the form 1,2,3,... to be converted to a hashmap
///
/// # Returns
/// HashMap<int32, int32> that maps an integer to itself
fn string_to_map(s: String) -> HashMap<i32, i32> {

    // split the input string based on ,
    let split = s.split(',');

    // initialize a hashmap to store the integers.
    let mut map = HashMap::new();
    
    for string in split {
        println!("{}", string);

        // convert each string element to an integer
        let s2: i32 = string
            .trim()
            .parse()
            .expect("Wanted a number");

        // Add each integer to the map
        map.insert(s2, s2);
    }

    return map;
}


/// Checks to see if there is a pair of values that sum to 0 in a given map
///
/// If two elements sum to zero then both a and -a are present in the map
/// so all we need to do is check if there exists a such that -a is also
/// present.  This is O(n) since the HashMap is o(1) access and we only
/// need to check every element.
///
/// # Args:
/// map: A hash map of integers to integers
///
/// # Returns
/// Boolean value true if there exists a pair of elements that sum to 0
///     false otherwise
fn sum_to_zero(map: HashMap<i32, i32>) -> bool {
    for (int1, int2) in &map {
        let temp = -1 * int2;
        match map.get(&temp) {
            Some(review) => return true,
            None =>  continue
        }
    }
    return false;
}
