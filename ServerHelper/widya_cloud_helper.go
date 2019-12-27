package main

import (
	"crypto/tls"
	"net/http"
	"io/ioutil"
	"fmt"
	"flag"
	"os"
	"time"
	"strings"
	//"net/url"
)

var (
	h 			bool
	upgrade     bool
	register    bool
	upgrade_url string
	user_code   string
)

func usage() {
    fmt.Fprintf(os.Stderr, `widya clode helper version: 1.0.0

	Usage: widya [-h] [-u] [-upgrade_url url] [-r] [-user_code code]

	Options:
`)
	flag.PrintDefaults()
}

func init(){
	flag.BoolVar(&h, "h", false, "this help")
	
	flag.BoolVar(&upgrade, "u", false, "Trigger cloud to issue the upgrade instruction")
	
	flag.BoolVar(&register, "r", false, "chose register user code")

    flag.StringVar(&upgrade_url, "upgrade_url", "http://106.15.227.27:9010/firmware/", "url for upgrade")
	
	flag.StringVar(&user_code, "user_code", "", "user code for register")
	
	flag.Usage = usage
}

func main(){
	flag.Parse()
 
    if h {
        flag.Usage()
    }
	
	if upgrade {
		TriggerUpgrade(upgrade_url)
		for range time.Tick(time.Second*8*60){  
			fmt.Println("start upgrade")
			TriggerUpgrade(upgrade_url)
		}	
	} 
	
	if register {
		RegisterUserCode(user_code)
	}
}

/*******
Address : https://api.umg-mm.com/device/update/all

Request 

Header 
  Content-Type : application/x-www-form-urlencoded
Body
  username: your_username
  currentVersion: version for upgrade
  url : url ota
  sha : sha256sum(upg_id_file.bin)
*******/
func TriggerUpgrade(upgrade_url string) error{
	tr := &http.Transport{
        TLSClientConfig:    &tls.Config{InsecureSkipVerify: true},
    }
    client := &http.Client{Transport: tr}
	
	//response, err := client.PostForm("https://106.15.227.27/upgrade",
    //    url.Values{"upgradeMode": {"silent"}, "sha": {"1c6f0b63d3f4e633c979791f15b5587822c1eb1b0e87ee5eb319e9212844ad10"}, "currentVersion": {"v0.1.1673532351"}, "url": {upgrade_url}})
	
	/*req := `{
	  "upgradeMode": "silent",
	  "sha": "2e03a997cc88ed840c17b1d35b0183455c1bda1957ba781ece680af4ac017d7f",
	  "currentVersion": "v0.1.1673609913",
	  "url": "http://192.168.1.134/"
	}`
	
    req_new := bytes.NewBuffer([]byte(req))
    request, _ := http.NewRequest("POST", "https://106.15.227.27/sys/v1/firmware/liaowenhua", req_new)
	
    request.Header.Set("Content-type", "application/json")
	request.Header["certificate"] = []string{"buGflY@335961="}
    response, err := client.Do(request)*/
	
	response, err := client.Post("https://api.umg-mm.com/device/update/all",
		"application/x-www-form-urlencoded",
        strings.NewReader("username=leon&currentVersion=v1.0.xxxxxx&url=xxxxxxxx&sha=xxxxxxxxx"))
    if err != nil {
        fmt.Println(err)
        return err 
    }
	
	defer response.Body.Close()
    body, err := ioutil.ReadAll(response.Body)
    if err != nil {
		fmt.Println(err)
        return err 
    }
 
    fmt.Println(string(body))
	
	return nil 
} 

func RegisterUserCode(code string) error{
	tr := &http.Transport{
        TLSClientConfig:    &tls.Config{InsecureSkipVerify: true},
    }
    client := &http.Client{Transport: tr}

	req, err := client.Post("https://106.15.227.27/a/code",
		"application/x-www-form-urlencoded",
        strings.NewReader("user_code=" + code))
		
	//req, err := client.Get("https://api.umg-mm.com/id/code?user_code=" + code)
    if err != nil {
		fmt.Println(err)
        return err 
    }
 
    defer req.Body.Close()
    body, err := ioutil.ReadAll(req.Body)
    if err != nil {
		fmt.Println(err)
        return err 
    }
 
    fmt.Println(string(body))
	
	return nil 
} 

func RequestToken() error{
	tr := &http.Transport{
        TLSClientConfig:    &tls.Config{InsecureSkipVerify: true},
    }
    client := &http.Client{Transport: tr}

	req, err := client.Post("https://ailivingtech.com/auth/O2/token",
		"application/x-www-form-urlencoded",
        strings.NewReader("grant_type=device_code&device_code=6cd945bd-7cb2-44e1-a62f-f73fef960898&user_code=VJxVGh"))
	
    if err != nil {
		fmt.Println(err)
        return err 
    }
 
    defer req.Body.Close()
    body, err := ioutil.ReadAll(req.Body)
    if err != nil {
		fmt.Println(err)
        return err 
    }
 
    fmt.Println(string(body))
	
	return nil 
} 
