package main

import (
    "fmt"
	"encoding/json"
)

type ASR struct {
	Corpus_no    	string  `json:"corpus_no"`
	Err_msg        	string  `json:"err_msg"`
	Err_no    		int 	`json:"err_no"`
	Result    		[]string `json:"result"`
	Sn    			string `json:"sn"`
}

func main(){
/*
    a := 12345
    
    b := strconv.Itoa(a)  
    fmt.Printf("%s, %d \n", b, a)
     
     print("hello test\n")*/
    //fmt.Printf("%c , %d , len: %d\n", a[0], a[0], len(a))
	ASRE := ASR{		
		"6681456508078924122",
		"success.",
		0,
		[]string{"北",},
		"697266196021555647819",
	}

	b, err := json.Marshal(&ASRE)
	if err == nil {
		fmt.Println(string(b)) 
	}
	
	jsonStr := `{
		"corpus_no":"6681456508078924122",
		"err_msg":"success.",
		"err_no":0,
		"result":["北京科技馆"],
		"sn":"697266196021555647819"
	}`
	
	if err := json.Unmarshal([]byte(jsonStr), &ASRE); err == nil {
		fmt.Println(ASRE) 
		fmt.Println(ASRE.Err_no) 
		fmt.Println(ASRE.Err_msg)
		fmt.Println(ASRE.Result[0])
	}
	
}