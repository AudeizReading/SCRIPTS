#!/bin/bash
# Script for adding, committing and pushing works with git
git add .
git commit -am "${1}"
git push origin master
