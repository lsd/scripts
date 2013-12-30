#!/bin/sh

# wheels - they get reinvented.

echo "-- move old files to versioned dir in ./.stale"
echo "-- hint: use !<enter> to rerun"
echo "                                             --"

revision() {
 echo `date +'%Y%m%d-%I%M%s'`
}

dir='.'
rootdir="$dir/.stale"
dest="$rootdir/revisions/`revision`/"
tmpdir="$rootdir/tmp"
echo "INFO: Destination will be $dest OK?"
read

echo "INFO: Moving files"

mkdir -p "$dest"
if [ $0 = 0 ]; then
  echo "FATAL: Failed to create $dest for old files"
  exit 11
fi

echo "Updating latest to point to $desc"
mkdir -p "$tmpdir"
mv "$rootdir/latest" "$tmpdir"
ln -s "$dest" "$rootdir/latest"
echo "latest symlink now points to your most recent changes"

#num="$1"
num="-5"
for f in $(ls -1t . | tail $num); do 
  mv "$f" "$dest"
  echo "   ==> Moved $f"; 
done
