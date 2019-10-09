#!/bin/bash
mkdir -p /usr/local/share/tourettes
cp -a `pwd`/* /usr/local/share/tourettes
sudo cp tourettes /usr/bin
sudo chmod a+x /usr/bin/tourettes
sudo chmod a+x /usr/local/share/tourettes/words.sh
sudo chmod a+x /usr/local/share/tourettes/randmp3.sh