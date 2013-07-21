#!/bin/sh
# Isam github.com/lsd

#DATA_DIR="`dirname ~`/`basename ~`/temp/Chrome"
DATA_DIR="$HOME/temp/Chrome"
CHROME='/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'

SWITCHES="\
  --user-data-dir=${DATA_DIR} \
  --disable-prompt-on-repost \
  --disable-popup-blocking \
  --keep-alive-for-test \
  --disable-extensions \
  --no-default-browser-check \
  --no-first-run \
  --disable-login-animations \
  --disable-geolocation \
  --disable-translate \
  --disable-webgl \
  --disable-audio \
  --disable-webaudio \
  --show-icons \
  --disable-plugins \
  --disable-sync \
  --show-icons \
  --enable-file-cookies \
  --no-pings \
  --no-swap-metrics \
  --disable-full-history-sync\
"

echo "Opening clean Google Chrome\n"
echo "* chrome binary: $CHROME"
echo "* user-data-dir: $DATA_DIR\n"
echo "* args/switches:"
for switch in $SWITCHES; do echo $switch; done
echo "\n* More switches @ http://peter.sh/experiments/chromium-command-line-switches/\n"

#echo "Proceed? (hit the Any key.)" && read
# mkdir -p $DATA_DIR

"$CHROME" 2> /dev/null $SWITCHES
echo "Chrome returned $?"
