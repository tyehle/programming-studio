package main

import "fmt"

func main() {
	all := allSums([]int{9, -6, -5, 9, 8, 3, -4, 8, 1, 7, -4, 9, -9, 1, 9, -9, 9, 4, -6, -8})
	fmt.Println(all)
}

func allSums(nums []int) [][]int {
	set := toSet(nums)
	out := make([][]int, 0)

	for a := range set {
		for b := range set {
			if set[-(a + b)] {
				out = append(out, []int{a, b, -(a+b)})
			}
		}
	}

	return out
}

func toSet(nums []int) map[int]bool {
	set := make(map[int]bool)
	for _, num := range nums {
			set[num] = true
	}
	return set
}
