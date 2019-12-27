#!/usr/bin/env python3.4

import requests
import json
import os

def list_test_case(path, list):
    file_list = os.listdir(path)  
    
    for file in file_list:
        list.append(file)
    return list        

def load_json_file(file):
    with open(file, 'r') as f:
        param = f.read()
    
    if len(param) <= 0:
        return None

    return json.loads(param)
    
def check_test_case_result(result, expect):
    for exp in expect:
        if exp in result.keys():
            if expect[exp] != result[exp]:
                return False
        else:
            return False 
    
    return True                       
    
def exec_test_case_from_net(param, right): 
    action = dev_url + param["action"] + "?"
            
    for test in param["test_case"]:  
        test_case_url = action
        for p in test["param"]:
            test_case_url += p + "=" + test["param"][p] + "&"
        
        test_case_url = test_case_url[:-1] 
        print("send request:" + test_case_url)   
        try:            
            r = requests.get(test_case_url)
        except Exception as err:
            print(err)
       
        result = json.loads(r.text)
        res = check_test_case_result(result, test["result"])
        right[test["id"]] = res
        
def init(cfg):
    if cfg["proto"] == "http":
        if cfg["port"] == "80":
            return "http://"+ cfg["ip"] + "/"
        else:
            return "http://"+ cfg["ip"] + ":" + cfg["port"] + "/"
            
    return None                
        
if __name__ == '__main__':
    cfg_file = './config/dev.cfg'
    test_case_root_path = './config/test_case/'
    test_case_list = []
    test_case_all_result = {}
    global dev_url
    
    cfg = load_json_file(cfg_file)
    dev_url = init(cfg)
    if dev_url == None:
        print("cfg file wrong")
        exit()
    
    list_test_case(test_case_root_path, test_case_list)
    for test_case in test_case_list:
        test_case_result = {}
        test_case_path = test_case_root_path + test_case
        test_case_json = load_json_file(test_case_path)
        exec_test_case_from_net(test_case_json, test_case_result)
        test_case_all_result[test_case_json["action"]] = test_case_result
    
    print("result :")
    print(test_case_all_result)           
