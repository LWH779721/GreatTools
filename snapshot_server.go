package main

import (
	"fmt"
	"net/http"
	//"strconv"
	"io"
	"os"
	"time"
)

func SnapshotHandler(w http.ResponseWriter, r *http.Request) {
	if "POST" == r.Method {
		file, header, err := r.FormFile("imageData")
		if err != nil {
			fmt.Println(err)
			http.Error(w, err.Error(), 500)
			return
		}
		
		defer file.Close()
		f, err := os.Create(header.Filename)
		defer f.Close()
		io.Copy(f, file)
		fmt.Println("ok")
		//fmt.Fprintf(w, "size: %d", file.(Sizer).Size())
		return
	}
}

func main() {
	http.HandleFunc("/snapshot", SnapshotHandler)
	http.ListenAndServe("10.0.39.253:8080", nil)
	
	for true{
	   time.Sleep(1) 
	}
}
