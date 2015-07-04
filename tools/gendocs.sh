#!/usr/bin/env bash

./Script.hx

haxe doc.hxml

cd ..

haxelib run dox -i tools/xml -o docs/api -in macrox -ex macrox.test --toplevel-package macrox -D version 0.0.1 --title "MacroX - Macro eXtended tools!" -theme tools/doxtheme -D source-path https://github.com/porfirioribeiro/MacroX/blob/development/src/

cd tools

rm -R xml