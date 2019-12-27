#!/bin/sh

# Renew Version's Timestamp In json file
RenewTs(){
	currentTimestamp=`date +%s`
	
	echo $currentTimestamp
}

#echo `cat ${S}/version`"."`date +%s`
RenewTs
