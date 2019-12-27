package main


func main(){
	array_test()
}

func array_test(){
	var a [2]int
	
	a[1] = 0
	//a[2] = 0 //err
	
	var b [...] int = {1, 2, 3}
	
	b[1] = 0
}