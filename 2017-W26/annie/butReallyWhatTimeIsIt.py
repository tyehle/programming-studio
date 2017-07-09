tests = ["00:00", "01:30", "12:05", "14:01", "20:29", "21:00"]

numToWord = {0 : "twelve",
       1 : "one",
       2 : "two",
       3 : "three",
       4 : "four",
       5 : "five",
       6 : "six",
       7 : "seven",
       8 : "eight",
       9 : "nine",
       10 : "ten",
       11 : "eleven",
       12 : "twelve",
       13 : "thirteen",}




def getWordHour( hour ):
  return numToWord[int(hour) % 12]

def getWordMinute( minute ):
  minuteNum = int(minute)
  lastDigit = int(minute[1])
  if minuteNum == 0:
    minuteWord = "oh clock"
  elif minuteNum < 10:
    minuteWord = "oh " + numToWord[minuteNum]
  elif minuteNum < 14:
    minuteWord = numToWord[minuteNum]
  elif minuteNum < 20:
    minuteWord = numToWord[lastDigit] + " teen"
  elif minuteNum == 20:
    minuteWord = "twenty"
  elif minuteNum < 30:
    minuteWord = "twenty " + numToWord[lastDigit]
  elif minuteNum == 30:
    minuteWord = "thirty "
  elif minuteNum < 40:
    minuteWord = "thirty " + numToWord[lastDigit]
  elif minuteNum == 40:
    minuteWord = "forty "
  elif minuteNum < 50:
    minuteWord = "forty " + numToWord[lastDigit]
  elif minuteNum == 50:
    minuteWord = "fifty "
  elif minuteNum < 60:
    minuteWord = "fifty " + numToWord[lastDigit]
  return minuteWord

def speechify( inputString ):
    if int(test[:2]) < 12:
        return getWordHour( test[:2] ) + " " + getWordMinute( test[3:] ) + " pee em"
    return getWordHour( test[:2] ) + " " + getWordMinute( test[3:] ) + " A em"

for test in tests:
   print( speechify( test )) 
