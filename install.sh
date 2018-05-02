#!/bin/bash
sudo cp -a `pwd` /usr/local/share
sudo cp tourettes /usr/bin
sudo chmod a+x /usr/bin/tourettes 
sudo rm -rf /usr/local/share/tourettes/.git
