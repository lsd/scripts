#!/bin/sh
function launchdemons__main() {
  declare -a paths=(~/Library/LaunchAgents ~/Library/LaunchDaemons /Library/LaunchDaemons /Library/LaunchAgents)

  echo "Startup Demons\n------------------------------"
  for p in ${paths[@]}; do
    if [ -e "$p" ]; then
      if [ "$1" ]; then
        echo "** Searching $p for $1..."
        ls -1 "$p" | grep "$1"
      else
        echo "** Listing files in $p..."
        ls -1 "$p"
      fi
      echo
    fi
  done
}

launchdemons__main "$1"
