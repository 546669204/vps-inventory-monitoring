package main

import (
	"fmt"
	"strings"
	"testing"
	"time"
)

func Test_main(t *testing.T) {
	i := 0
	for i < 100 {
		fmt.Printf("\r")
		fmt.Printf("%s", strings.Repeat("x", i))
		time.Sleep(time.Millisecond * 50)
		i++
	}
}
