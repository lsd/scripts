#!/bin/sh
# Isam github.com/lsd | 08/05/2013 public domain
# Uses AudioSwitcher to toggle bwt 2 audio sources
# REQUIRE:
#   AudioSwitcher
#   http://github.com/deweller/switchaudio-osx

# SUGGEST:
#   Growl version 2.x OR 1.x
#   growlnotify (avail for 2.x and 1.x)
#   http://growl.info/downloads#generaldownloads

BIN="AudioSwitcher"
SPEAKERS='Built-in Output'
HEADPHONES='Sound Blaster Tactic(3D) Alpha'

CURRENT="`$BIN -c`"

"$BIN" -c | grep "$SPEAKERS"
if [ $? -eq 0 ]; then
  "$BIN" -s "$HEADPHONES" > /dev/null
else
  "$BIN" -s "$SPEAKERS" > /dev/null
fi

"growlnotify" -v 2>&1 /dev/null
if [ $? -eq 0 ]; then
  growlnotify -t "Audio Out Now" -m "`$BIN -c`"
fi
