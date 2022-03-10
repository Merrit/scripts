#!/bin/bash

cd ~/Dropbox/Notes/ || exit

git add .
git commit -m "automated notes push"
git push
