package main

import (
  "fmt"
  "sort"
)

/*
Only possibly a direct implementation of the wiki pseudocode:
https://en.wikipedia.org/wiki/3SUM
*/

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
    tests := [][]int{{9, -6, -5, 9, 8, 3, -4, 8, 1, 7, -4, 9, -9, 1, 9, -9, 9, 4, -6, -8},
                    {4, 5, -1, -2, -7, 2, -5, -3, -7, -3, 1},
                    {-1, -6, -3, -7, 5, -8, 2, -8, 1},
                    {-5, -1, -4, 2, 9, -9, -6, -1, -7}}


    for i := 0; i < len(tests); i++ {
      fmt.Println("   Running dataset ", i, ": ", tests[i])
      menageatrois( tests[i] )
      fmt.Println("")
    }
    fmt.Println("Done!")
}
