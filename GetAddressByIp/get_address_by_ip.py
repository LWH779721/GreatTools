#!/usr/bin/python3
# -*- coding:utf-8 -*-
# author:LWH

import sys
import urllib.request
import json
import re

def get_wild_ip():
    	#url = "http://183.58.18.96/ip2city.asp"
    	#url = "http://42.120.158.5/static/customercare/yourip.asp"
		url = "https://ifconfig.me/"
    	#url = "https://www.baidu.com"
		#try:
		request = urllib.request.Request(url)
		res_data = urllib.request.urlopen(request)
		res = res_data.read()
		#except ConnectionResetError:
		print("Error: http 请求失败")

		return re.search('\d+\.\d+\.\d+\.\d+',res.decode("gb2312")).group(0)

def get_ip_information(ip):
    url='http://api.map.baidu.com/highacciploc/v1?qcip='+ip+'&qterm=pc&ak=bPdVuky3QNa0yDKVA3YfDL2QkO0hpM3s&coord=bd09ll&extensions=3'
    request = urllib.request.Request(url)
    res_data = urllib.request.urlopen(request)
    res = res_data.read()
    data_dic = json.loads(res.decode("utf-8"))    

    if ("content" in data_dic):
        content=data_dic["content"]
        address_component=content["address_component"]
        formatted_address=content["formatted_address"]
        print ("你的具体位置为：")
        print (address_component["country"])
        print (formatted_address)
        if ("pois" in content):
            print ("你附近POI信息如下：")
            pois = content["pois"]
            for index in range(len(pois)):
                pois_name = pois[index]["name"]
                pois_address = pois[index]["address"]
                print (pois_name, pois_address)
    else:
        print ('IP地址定位失败！！！')

if __name__ == '__main__':
    get_ip_information(get_wild_ip())
    input()
