#!/bin/sh
# Isam (Biodegradablegeek.com) public domain 12/28/2008
# Basic BASH script to dump and compress a MySQL dump

out=sequel_`date +'%m%d%Y_%M%S'`.sql
dest=/bx/

function e { 
  echo -e "\n** $1" 
}

e "Dumping SQL file ($out). May take awhile..."
#echo "oh snap" > $out 
sudo mysqldump -u root -p --all-databases > $out
if [ $? -ne 0 ]; then
  e "MySQL dump failed. Check that server is up and your username/pass"
  exit 7
fi

e "Uncompressed SQL file size"
du -hs $out

e "Compressing SQL file"
gz=$out.tar.gz
tar -zvvcf $gz $out
rt=$?

if [ $rt -ne 0 ]; then
  e "tar failed (error=$rt). Will NOT remove uncompressed SQL file"
else
  e "Removing uncompressed SQL file"
  rm -f $out
  out=$gz

  e "Compressed SQL file size"
  du -hs $out
fi

e "Moving shit to '$dest'" 
sudo mv $out $dest


