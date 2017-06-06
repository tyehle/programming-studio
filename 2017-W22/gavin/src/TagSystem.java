import java.util.*;

public class TagSystem {
    
    public static void main(String[] args) {
        
        //dictionary of rules for what to append to the end of the String
        Map<String, String> productionRules = new HashMap<String, String>();
        productionRules.put("a", "bc");
        productionRules.put("b", "a");
        productionRules.put("c", "aaa");
        
        //pass starting word, deletion number, and productionRules
        performOperation("aaa", 2, productionRules);
        System.out.println("\n");
        performOperation("aaaaaaa", 2, productionRules);
    }
    
    public static void performOperation(String word, int deletionNumber, Map<String, String> rules) {
        System.out.println(word);
        //using predefinded halting parameter
        //stop when word is less than 2 characters
        while (word.length() > 1) {
            //New Implementation
            //append corresponding value of the first character from rules dictionary
            //Look, it's only three lines!!!
            word = word + rules.get(String.valueOf(word.charAt(0)));
            word = word.substring(deletionNumber);
            System.out.println(word);
        }
    }
    
}
