#!/bin/bash

date +"Year: %Y, Month: %m, Day: %d" >> ./test.log
./.listener.sh >> ./test.log & 
