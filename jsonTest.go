package main

import (
    "fmt"
    "encoding/json"
)

type Student struct {
    Name    string
    Age        int
    Guake    bool
    Classes    []string
    Price    float32
}

func main() {
    st := &Student {
        "Xiao Ming",
        16,
        true,
        []string{"Math", "English", "Chinese"},
        9.99,
    }

    b, err := json.Marshal(st)
    if err == nil {
        fmt.Println("encoded data : ")
        fmt.Println(string(b))
    }
	
   /* ch := make(chan string, 1)
    go func(c chan string, str string){
        c <- str
    }(ch, string(b))
    strData := <-ch
    fmt.Println("--------------------------------")
    stb := &Student{}
    stb.ShowStu()
    err = json.Unmarshal([]byte(strData), &stb)
    if err != nil {
        fmt.Println("Unmarshal faild")
    } else {
        fmt.Println("Unmarshal success")
        stb.ShowStu()
    }*/
}