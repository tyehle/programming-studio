package talkingclock;

import java.util.HashMap;
import java.util.Map;

public class TalkingClock {
    
    public static void main(String[] args) {
        convertClock("00:00");
        convertClock("01:30");
        convertClock("12:05");
        convertClock("14:01");
        convertClock("20:29");
        convertClock("21:00");
    }
        
    public static void convertClock (String inputString) {
        String hour = inputString.substring(0, 2);
        String minute = inputString.substring(3);
        String outputString = "It's ";
        
        Map<String, String> hours = new HashMap<String, String>();
        hours.put("00", "twelve ");
        hours.put("01", "one ");
        hours.put("02", "two ");
        hours.put("03", "three ");
        hours.put("04", "four ");
        hours.put("05", "five ");
        hours.put("06", "six ");
        hours.put("07", "seven ");
        hours.put("08", "eight ");
        hours.put("09", "nine ");
        hours.put("10", "ten ");
        hours.put("11", "eleven ");
        hours.put("12", "twelve ");
        hours.put("13", "one ");
        hours.put("14", "two ");
        hours.put("15", "three ");
        hours.put("16", "four ");
        hours.put("17", "five ");
        hours.put("18", "six ");
        hours.put("19", "seven ");
        hours.put("20", "eight ");
        hours.put("21", "nine ");
        hours.put("22", "ten ");
        hours.put("23", "eleven ");
        
        Map<String, String> minutes = new HashMap<String, String>();
        minutes.put("00", " ");
        minutes.put("01", "oh one ");
        minutes.put("02", "oh two ");
        minutes.put("03", "oh three ");
        minutes.put("04", "oh four ");
        minutes.put("05", "oh five ");
        minutes.put("06", "oh six ");
        minutes.put("07", "oh seven ");
        minutes.put("08", "oh eight ");
        minutes.put("09", "oh nine ");
        minutes.put("10", "ten ");
        minutes.put("11", "eleven ");
        minutes.put("12", "twelve ");
        minutes.put("13", "thirteen ");
        minutes.put("14", "fourteen ");
        minutes.put("15", "fifteen ");
        minutes.put("16", "sixteen ");
        minutes.put("17", "seventeen ");
        minutes.put("18", "eighteen ");
        minutes.put("19", "nineteen ");
        minutes.put("20", "twenty ");
        minutes.put("21", "twenty one ");
        minutes.put("22", "twenty two ");
        minutes.put("23", "twenty three ");
        minutes.put("24", "twenty four ");
        minutes.put("25", "twenty five ");
        minutes.put("26", "twenty six ");
        minutes.put("27", "twenty seven ");
        minutes.put("28", "twenty eight ");
        minutes.put("29", "twenty nine ");
        minutes.put("30", "thirty ");
        minutes.put("31", "thirty one ");
        minutes.put("32", "thirty two ");
        minutes.put("33", "thirty three ");
        minutes.put("34", "thirty four ");
        minutes.put("35", "thirty five ");
        minutes.put("36", "thirty six ");
        minutes.put("37", "thirty seven ");
        minutes.put("38", "thirty eight ");
        minutes.put("39", "thirty nine ");
        minutes.put("40", "forty ");
        minutes.put("41", "forty one ");
        minutes.put("42", "forty two ");
        minutes.put("43", "forty three ");
        minutes.put("44", "forty four ");
        minutes.put("45", "forty five ");
        minutes.put("46", "forty six ");
        minutes.put("47", "forty seven ");
        minutes.put("48", "forty eight ");
        minutes.put("49", "forty nine ");
        minutes.put("50", "fifty ");
        minutes.put("51", "fifty one ");
        minutes.put("52", "fifty two ");
        minutes.put("53", "fifty three ");
        minutes.put("54", "fifty four ");
        minutes.put("55", "fifty five ");
        minutes.put("56", "fifty six ");
        minutes.put("57", "fifty seven ");
        minutes.put("58", "fifty eight ");
        minutes.put("59", "fifty nine ");
        
        //System.out.println(hour);
        //System.out.println(minutes);
        
        outputString += hours.get(hour);
        outputString += minutes.get(minute);
        if (Integer.parseInt(hour) < 12) {
            outputString += "am";
        } else {
            outputString += "pm";
        }
        System.out.println(outputString);
    }
    
}
