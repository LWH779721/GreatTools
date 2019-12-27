package main

import (
    . "fmt"
    "net"
    "os"
)

func main(){
    server := "127.0.0.1:8080"
    
    tcpAddr, err := net.ResolveTCPAddr("tcp4", server)
    if err != nil{
        Println(err.Error())
        os.Exit(1)
    }
    
    listener, _ := net.ListenTCP("tcp", tcpAddr)
    
    for true {
        conn, _ := listener.Accept()
        
        Println("accept new")
        go handleClient(conn)   
    }
}

func handleClient(conn net.Conn) {
    defer conn.Close()
    var buf [512]byte
    for {
        n, err := conn.Read(buf[0:])
        if err != nil {
            return
        }
        rAddr := conn.RemoteAddr()
        Println("Receive from client", rAddr.String(), string(buf[0:n]))
        _, err2 := conn.Write([]byte("Welcome client!"))
        if err2 != nil {
            return
        }
    }
}