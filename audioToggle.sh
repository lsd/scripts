#!/bin/sh
# Isam github.com/lsd | 08/05/2013 public domain
# Uses AudioSwitcher (audioswitcher-osx) to toggle 
# between 2 audio sources

#CURRENT="`~/bin/AudioSwitcher -c`"
SPEAKERS='Built-in Output'
HEADPHONES='Sound Blaster Tactic(3D) Alpha'

~/bin/AudioSwitcher -c | grep "$SPEAKERS"
if [ $? -eq 0 ]; then
  ~/bin/AudioSwitcher -s "$HEADPHONES"
else
  ~/bin/AudioSwitcher -s "$SPEAKERS"
fi

echo "Switched to `~/bin/AudioSwitcher -c`"
