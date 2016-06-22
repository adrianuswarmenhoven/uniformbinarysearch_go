package main

import (
	"fmt"
)

const (
	LOG_N = 4 //2^10 where 10 is length of array
)

var (
	delta = make([]int, 4, 4) //Log 2^N
)

func make_delta(N int) {
	delta = make([]int, 256, 256)
	power := 1
	i := 0

	for {
		half := power
		power = power << 1
		delta[i] = (N + half) / power
		if delta[i] == 0 {
			break
		}
		i++
	}
}

func unisearch(a []int, key int) int { //returns index or -1
	i := delta[0] - 1
	d := 0
	for {
		if key == a[i] {
			return i
		} else if delta[d] == 0 {
			return -1
		} else {
			if key < a[i] {
				d++
				i -= delta[d]
			} else {
				d++
				i += delta[d]
			}
			if i < 0 {
				return -1
			}
		}
	}
}

const (
	N = 10
)

func main() {
	a := []int{1, 3, 5, 6, 7, 9, 14, 15, 17, 19}
	make_delta(N)
	for i := 0; i < 20; i++ {
		fmt.Printf("%d is at index %d\n", i, unisearch(a, i))
	}
}

/*

   for (i=0; i < 20; ++i)
     printf("%d is at index %d\n", i, unisearch(a, i));
*/
