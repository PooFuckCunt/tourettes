#!/bin/bash
FILES=/tmp/tourettes/.swords
SW_PATH=/usr/local/share/tourettes/swearwords
WORDS=/usr/local/share/tourettes/words
one=`sort -R list.txt |head -1`
two=`sort -R list.txt |head -1`
three=`sort -R list.txt |head -1`
one1=`sort -R list.txt |head -1`
two1=`sort -R list.txt |head -1`
three1=`sort -R list.txt |head -1`
PLAYER=`grep 'PLAYER' config | sed -e 's#.*=\(\)#\1#'`
#added date timestamp to mp3 encodes
DATE=`date +%d-%m-%Y-%H:%M:%S`

find $SW_PATH -iname '*-*' > $FILES
find $WORDS -iname '*-*' >> $FILES
for words in $@
do
if grep -q "/$words-" $FILES; then
echo 'poo fart' >> /dev/null 
else
    echo "$words not found" ; exit
fi
done
for words in $@
do
 cat `grep "/$words-"  $FILES |head -n1` >> /tmp/tourettes/phrase.0.mp3
done

ffmpeg -y -i /tmp/tourettes/phrase.0.mp3 -metadata date="$DATE" -metadata title="$one1 $two1 $three1" -metadata artist="$one $two $three" -vn -ar 44100 -ac 2 -ab 48k -f mp3 /tmp/tourettes/phrase.mp3 > /dev/null 2>&1

rm /tmp/tourettes/phrase.0.mp3
$PLAYER /tmp/tourettes/phrase.mp3