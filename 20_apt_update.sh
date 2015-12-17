#!/bin/bash


[ "$BASE_APTLIST" ] && APTLIST="$BASE_APTLIST ""$APTLIST"
#[ "$APTLIST" ] && (echo "We are now refreshing packages from apt repositorys, this *may* take a while" && apt-get update -qq && apt-get --only-upgrade install -yqq $APTLIST)

[ "$APTLIST" ] && apt-get update -yqq && 
if [ $? != 0 ]; then
	echo "The Dynamic apt mirrors seems to be not working. Trying to fix with method one"
	apt-get clean && rm -rf /var/lib/apt/lists/*
	apt-get update -yf 
	if [ $? != 0 ]; then
		echo "Method one seemed to have failed. Lets try method 2."
		apt-get clean && rm -rf /var/lib/apt/lists/*
		mv -v /etc/apt/sources.list /etc/apt/sources.list.org
		mv -v /etc/apt/sources.list.failover /etc/apt/sources.list
		apt-get update -yf 
	    if [ $? != 0 ]; then
	    	echo "I have tryed everything, nothing works. Provide logs to #linuxserver.io@freenode"
	    	exit 1
	    fi
	fi

fi


sleep 1s
