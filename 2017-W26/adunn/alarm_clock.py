"""
Description
No more hiding from your alarm clock! You've decided you want your
computer to keep you updated on the time so you're never late again.
A talking clock takes a 24-hour time and translates it into words.

Input Description
An hour (0-23) followed by a colon followed by the minute (0-59).

Output Description
The time in words, using 12-hour format followed by am or pm.

Sample Input data
00:00
01:30
12:05
14:01
20:29
21:00

Sample Output data
It's twelve am
It's one thirty am
It's twelve oh five pm
It's two oh one pm
It's eight twenty nine pm
It's nine pm
"""

import sys
import inflect

def int_to_word(num):
    p          = inflect.engine()
    string_int = p.number_to_words(num)
    return string_int.replace("-", " ") # change inflect formatting to match expected output

# get the input
input = raw_input("> ")

# error checking
try:
    hour, minute = input.split(":")
    hour         = int(hour)
    minute       = int(minute)
    if hour not in range(0,24) or minute not in range(0,60):
        raise ValueError
except ValueError:
    print "Input should be an hour (0-23) followed by a colon followed by the minute (0-59). e.g. 12:30"
    sys.exit(1)

# this needs to go before hour modulo operation
meridiem = "am" if hour < 12 else "pm"

# convert hour to 12-hour format
if hour == 0 or hour == 12:
    hour = 12
else:
    hour %= 12

# convert hour and minute to word representation
add_oh = "oh " if minute < 10 else ""
hour   = int_to_word(hour)
minute = "" if minute == 0 else add_oh + int_to_word(minute)

# print output (make sure there's no extra spaces)
output = "It's %s %s %s" % (hour, minute, meridiem)
print ' '.join(output.split())
