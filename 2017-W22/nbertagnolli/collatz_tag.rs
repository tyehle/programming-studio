/// This File takes a string of 'a' characters and performs a 2-tag
/// collatz reduction on it


// Import necessary libraries
use std::io;
use std::collections::HashMap;

fn main() {
    println!("Enter a string of n a's where n is the number you want to start from");

    // Create a holder for the raw input
    let mut raw_input = String::new();

    // Read from standard in
    io::stdin()
        .read_line(&mut raw_input)
        .expect("Failed to read line");

    // Print out the input that was entered
    // string.len() returns the number of bytes in the string
    // subtract 1 for the newline character at the end.
    raw_input.pop();
    let str_len = raw_input.chars().count();

    println!("Your string is of size {}", str_len);
    // TODO:: Check for only a's
    
    // apply the tag system
    collatz(raw_input);
}


/// Reduces a string of a's to a single a by using a 2-tag system and the collatz conjecture
///
/// # Args
/// s: String of n a's to be reduce
///
/// # Returns
/// Void:  No return but it will print out each tag reduction as it reduces
fn collatz(s: String) -> () {
    // Create a map for the two tag system
    // Unfortunately Rust does not have a map literal syntax you would need to create
    // a macro for this, see stackoverflow.com/questions/27582739/how-do-i-create-a-hashmap-lieteral
    let mut tag_map: HashMap<char, String> = HashMap::new();
    tag_map.insert('a', "bc".to_string());
    tag_map.insert('b', "a".to_string());
    tag_map.insert('c', "aaa".to_string());

    // Calculate the initial string length subtract 1 for newline character
    let mut str_len = s.chars().count() - 1;
    
    // Create a mutable version of the string to work with
    let mut tag_str: String  = s.chars().collect();
    println!("{}", tag_str);
    
    // While the string is greater than 1 use the tag system rules to update and print the string
    while str_len > 1 {
        // Extract the first character
        let first: Option<char> = tag_str.chars().nth(0);
        
        // Remove the first two characters
        tag_str = tag_str.chars().skip(2).take(str_len).collect();

        // Append the new tag at the end of the string
        let add_str: &str  = tag_map.get(&first.unwrap()).unwrap();
        // let poop = [tag_str, &*add_str].concat();
        //println!("pattern is: {}", add_str);
        tag_str.push_str(add_str);

        // Print the new string
        println!("{}", tag_str);

        // Recalculate string length
        str_len = tag_str.chars().count();
    }

}
