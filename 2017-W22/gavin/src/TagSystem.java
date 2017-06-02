
public class TagSystem {
    
    public static void main(String[] args) {
        //pass starting word and deletion number
        performOperation("aaa", 2);
        System.out.println("\n");
        performOperation("aaaaaaa", 2);
    }
    
    public static void performOperation(String word, int deletionNumber) {
        System.out.println(word);
        //using predefinded halting parameter
        //stop when word is less than 2 characters
        while (word.length() > 1) {
            //using predefined production rules
            switch (word.charAt(0)) {
                case 'a':
                    word = word + "bc";
                    //System.out.println(word);
                    break;
                case 'b':
                    word = word + "a";
                    //System.out.println(word);
                    break;
                case 'c':
                    word = word + "aaa";
                    //System.out.println(word);
                    break;
                default:
                    break;
            }
            word = word.substring(deletionNumber);
            System.out.println(word);
        }
    }
    
}
