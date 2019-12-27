package main

import (
	"fmt"
	"time"
)

func recv(ch chan int){
    for i := range ch {
		fmt.Println(i)
	}
	
	fmt.Println("closed")
}

func main(){
	var ch chan int
	
	ch = make(chan int, 2)
	
	go recv(ch)
	ch <- 1
	
	close(ch)
	
	ch <- 2
	
	time.Sleep(30 * time.Second)
}