object RotateStrings {
  
    def rotateString(x: String): String = {
	  	val cat = x + x
	  	var best = x
	  	for (i <- List.range(1, x.length)) {
	  		val sub = cat.substring(i, i + x.length)
	  		if (sub < best) {
	  			best = sub
	  		}
	  	}
	  	
	  	best
  }  
  
  def main(args: Array[String]): Unit = {
    println("Hello, world!")
    println("onion:  " + rotateString("onion"))
    println("poop:   " + rotateString("poop"))
    
  }
}