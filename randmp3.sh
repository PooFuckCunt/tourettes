#!/bin/bash
#number of files to keep put one more than desired number e.g 11 for total of 10
keepX=11
#mp3 player
PLAYER="mpv"
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
rand=$(( ( RANDOM % 65 )  + 2 ))
#create dir 
mkdir -p /tmp/tourettes
#create random mp3
cat `ls swearwords/*.mp3 |shuf |sort -R |shuf |sort -R |head -n$rand` > /tmp/tourettes/tourettes.0.mp3
#reencode mp3
ffmpeg -y -i /tmp/tourettes/tourettes.0.mp3 -metadata title="$one1 $two1 $three1" -metadata artist="$one $two $three" -vn -ar 44100 -ac 2 -ab 48k -f mp3 /tmp/tourettes/tourettes.$NAME.mp3 > /dev/null 2>&1
#clean up old mp3s
rm /tmp/tourettes/tourettes.0.mp3
cd /tmp/tourettes && ls -tp | grep -v '/$' | tail -n +$keepX | xargs -d '\n' -r rm --
$PLAYER /tmp/tourettes/tourettes.$NAME.mp3
#ffmpeg -i /tmp/tourettes/tourettes.mp3 -loop 1 -i ~/tourettes/images/04.png -shortest /tmp/out.avi
