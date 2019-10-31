#!/bin/bash

while true; do
    read -p "Do you wish to uninstall tourettes? Doing so will delete any files you added yourself y/n" yn
    case $yn in
        [Yy]* ) sudo rm -r /usr/local/share/tourettes && sudo rm /usr/bin/tourettes ; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done