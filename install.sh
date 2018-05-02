#!/bin/bash
sudo mkdir -p /usr/local/share/tourettes
sudo cp -a `pwd`/* /usr/local/share/tourettes
sudo cp tourettes /usr/bin
sudo chmod a+x /usr/bin/tourettes
