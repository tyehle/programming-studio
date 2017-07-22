package main

import (
  "fmt"
  "sort"
)


func menageatrois(arr []int) {
   sort.Ints( arr )
   for outer := 0; outer < len(arr); outer++ {

  var a = arr[outer]
        var start = outer+1
  var end = len(arr)-1

  for ; start < end ; {
    var b = arr[start]
    var c = arr[end]

    switch {
    case a+b+c == 0:
          fmt.Println(a, b, c)
      end -=1
    case a+b+c > 0:
      end -=1
    default:
      start += 1
    }
      end -= 1
  }
 }
}


/*
-9 1 8
-8 1 7
-5 -4 9
-5 1 4
-4 1 3
-4 -4 8
*/

func main() {
    arr := []int {9, -6, -5, 9, 8, 3, -4, 8, 1, 7, -4, 9, -9, 1, 9, -9, 9, 4, -6, -8}
    menageatrois( arr )
    fmt.Println("Done!")
}

