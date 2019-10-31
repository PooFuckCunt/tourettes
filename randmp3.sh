#!/bin/bash
#do not edit values below use the config file
#number of files to keep put one more than desired number e.g 11 for total of 10 (value can be set in config)
keepX=$(expr 1 + `grep 'keep' config | sed -e 's#.*=\(\)#\1#'`)
#mp3 player (value can be set in config)
PLAYER=`grep 'PLAYER' config | sed -e 's#.*=\(\)#\1#'`
#lowest and highest numbers (value can be set in config)
RANGE=`grep 'RANGE' config | sed -e 's#.*=\(\)#\1#'`
#percentage of random space between words (value can be set in config)
RANSPACE=`grep 'RANSPACE' config | sed -e 's#.*=\(\)#\1#'`
#added date timestamp to mp3 encodes
DATE=`date +%d-%m-%Y-%H:%M:%S`
#cant think of better way to do this but this is for random words for artist and title in ffmpeg
one=`sort -R list.txt |head -1`
two=`sort -R list.txt |head -1`
three=`sort -R list.txt |head -1`
one1=`sort -R list.txt |head -1`
two1=`sort -R list.txt |head -1`
three1=`sort -R list.txt |head -1`
#randome string for filename
NAME=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 5 | head -n 1)
#random number for mp3 list
rand=`shuf -i $RANGE -n 1`
#number of clear space mp3s to merge
CLEARNUM=$(bc <<<"`echo $rand`*$RANSPACE/100")
#create dir 
mkdir -p /tmp/tourettes
#generate clear mp3 list
find space -iname "*.mp3" > /tmp/tourettes/clear.lst; find space -iname "*.mp3" >> /tmp/tourettes/clear.lst; find space -iname "*.mp3" >> /tmp/tourettes/clear.lst; find space -iname "*.mp3" >> /tmp/tourettes/clear.lst
shuf /tmp/tourettes/clear.lst |head -n$CLEARNUM |shuf > /tmp/tourettes/filelist.txt 
#create random mp3 file list
find swearwords  -iname '*.mp3' | shuf | shuf  |head -n$rand >> /tmp/tourettes/filelist.txt
#shuffle and merge list
cat `shuf /tmp/tourettes/filelist.txt |shuf` > /tmp/tourettes/tourettes.0.mp3
#reencode mp3
ffmpeg -y -i /tmp/tourettes/tourettes.0.mp3 -metadata date="$DATE" -metadata title="$one1 $two1 $three1" -metadata artist="$one $two $three" -vn -ar 44100 -ac 2 -ab 48k -f mp3 /tmp/tourettes/tourettes.$NAME.mp3 > /dev/null 2>&1
#clean up old mp3s
rm /tmp/tourettes/tourettes.0.mp3
cd /tmp/tourettes && ls -tp | grep -v '/$' | tail -n +$keepX | xargs -d '\n' -r rm --
#play the fucking mp3
$PLAYER /tmp/tourettes/tourettes.$NAME.mp3

