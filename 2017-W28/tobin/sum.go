package main

import "fmt"
import "sort"

type triple struct { a, b, c int }

func main() {
	input := [][]int{{9, -6, -5, 9, 8, 3, -4, 8, 1, 7, -4, 9, -9, 1, 9, -9, 9, 4, -6, -8},
		{4, 5, -1, -2, -7, 2, -5, -3, -7, -3, 1},
		{-1, -6, -3, -7, 5, -8, 2, -8, 1},
		{-5, -1, -4, 2, 9, -9, -6, -1, -7}}

	for _, nums := range input {
		fmt.Println(nums)

		all := allSums(nums)

		for _, tri := range all {
			fmt.Println(tri)
		}

		fmt.Println()
	}
}

func allSums(nums []int) []triple {
	set := make(map[int]int)
	for _, num := range nums {
			set[num]++
	}

	sort.Ints(nums)

	out := make([]triple, 0)

	for i, a := range nums {
		set[a]--
		for j:=i+1; j<len(nums); j++ {
			b := nums[j]

			if set[-(a + b)] > 0 {
				c := -(a + b)

				if c == b && set[c] == 1 {
					continue
				}

				var new triple
				if c < a {
					new = triple{c, a, b}
				} else if c < b {
					new = triple{a, c, b}
				} else {
					new = triple{a, b, c}
				}

				out = append(out, new)
			}
		}
	}

	outSet := make(map[triple]bool)
	for _, tri := range out {
			outSet[tri] = true
	}

	out = make([]triple, 0)
	for tri := range outSet {
		out = append(out, tri)
	}

	return out
}
