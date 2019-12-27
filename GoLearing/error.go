package main

import (
    "fmt"
    "errors"
    "os"
    "net"
)

func sqr() error {
    return errors.New("error test")
}

func main(){
    err := sqr()
    if err != nil {
        fmt.Printf("%s \n", err.Error())
    }
    
    addrs, err := net.InterfaceAddrs()

	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	for _, address := range addrs {

		// check i
		if ipnet, ok := address.(*net.IPNet); ok && !ipnet.IP.IsLoopback() {
			if ipnet.IP.To4() != nil {
				fmt.Println(ipnet.IP.String())
			}

		}
	}
}