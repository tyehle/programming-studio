def next_thing( x ):
  if x == 'a':
    return ['b', 'c']
  elif x == 'b':
    return ['a']
  elif x == 'c':
    return ['a', 'a', 'a']
  else:
    return "wtf is this?"


def token_thing( xs ) :
  print xs
  if (len( xs ) == 1):
    if (xs[0] == 'a'):
      return "we did it!"
    else:
      return "ono we fucked up"
  return token_thing( xs[2:] + next_thing( xs[0] ))
  
print token_thing( ['a', 'a', 'a'] )
print token_thing( ['a', 'a', 'a', 'a', 'a'])
print token_thing( ['a', 'a', 'a', 'a', 'a', 'a', 'a'] )

