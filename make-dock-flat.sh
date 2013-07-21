#!/bin/sh

CMD='defaults write com.apple.dock no-glass -boolean YES'
DIE='killall Dock'

echo $CMD
`$CMD`

echo $DIE
`$DIE`

echo "dont"
