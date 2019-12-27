package main

import (
    "fmt"
    "runtime"
	"time"
)

func init() {
	fmt.Println("init")
    runtime.GOMAXPROCS(1)
}

func say(s string){
    for i := 0; i < 100; i++ {
        //runtime.Gosched()
        fmt.Println(s)
    }
}
func main() {
    go say("world")
	//time.Sleep(1*time.Second)
    say("hello")
	time.Sleep(1*time.Second)
}
/*
func main() {
    fmt.Println("cpus:", runtime.NumCPU())
    fmt.Println("goroot:", runtime.GOROOT())
    fmt.Println("archive:", runtime.GOOS)
}*/
