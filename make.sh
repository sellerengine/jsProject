#! /bin/bash

rm -rf ./build/
node r.js -o webapp/src/app.build.js
# Get rid of coffee files after build, not needed
rm -f ./build/src/*.coffee

