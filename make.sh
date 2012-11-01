#! /bin/bash

rm -rf ./build/
node ../jsProject/r.js -o webapp/src/app.build.js
# Add require.js from jsProject
cp ../jsProject/lib/require.js ./build/src/require.js
# Get rid of coffee files after build, not needed
rm -f ./build/src/*.coffee
rm -f ./build/src/*.css

