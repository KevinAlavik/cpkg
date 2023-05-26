#!/bin/bash
git clone https://github.com/kevinalavik/cpkg
cd cpkg
sudo chmod +xrw src/cpkg.sh
sudo cp src/cpkg.sh /usr/local/bin/cpkg
cd ..
sudo rm -rf cpkg/
