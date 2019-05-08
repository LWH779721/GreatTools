package main

import (
    "log"
    "net/http"
	"os"
	"io/ioutil"
)

func FileRead(path string) []byte{  
    fi,err := os.Open(path)  
    if err != nil{
		panic(err)
	}
	
    defer fi.Close()  
    buffer ,err := ioutil.ReadAll(fi)  
 
    return buffer  
}  

func handler(w http.ResponseWriter, req *http.Request) {
    w.Header().Set("Content-Type", "text/plain")
    w.Write([]byte("This is an example server.\n"))
}

func musicHandler(w http.ResponseWriter, req *http.Request) {
	
    w.Header().Set("Content-Type", "audio/mp3")
    w.Write(FileRead("2.mp3"))
}

func main() {
    http.HandleFunc("/", handler)
	http.HandleFunc("/music", musicHandler)
    log.Printf("About to listen on 10443. Go to https://127.0.0.1:10443/")
    // One can use generate_cert.go in crypto/tls to generate cert.pem and key.pem.
    // ListenAndServeTLS always returns a non-nil error.
    err := http.ListenAndServeTLS(":8000", "cert.pem", "key.pem", nil)
    log.Fatal(err)
}