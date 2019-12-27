#!/usr/bin/python3

import time
import json
import sys

# Renew Version's Timestamp In json file
def RenewTs(jsonFile):
	ticks = time.time()
	ts = str(ticks)
	index = ts.find(".")
	ts1 = ts[:index]
	print(ts1)
	with open(jsonFile, encoding='utf-8') as f:
		data = json.load(f)
		version = data['app']['firmwareVersion']
		print(version)
		index = version.rfind(".")
		newVersion = version[:index+1] + ts1
		print(newVersion)
		data['app']['firmwareVersion'] = newVersion
		with open("test.json", 'w') as f1:
			json.dump(data, f1, indent=4)

RenewTs(sys.argv[1])