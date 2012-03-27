#!/bin/sh
# 
# 04/01/2009 | http://biodegradablegeek.com | GPL 
# 
# You should be in site (NOT public) root (be in same dir as public/ log/ etc)
# proto/ is created and will house the jekyll prototype
# public/ will be the generated static site
# the public/ folder will be REMOVED and regenerated on every push
# 

if [ -z "$1" ]; then
  echo "Usage: ./repogen.sh domain.com\n"
  exit
fi


# optional. will make it easier to copy/paste cmd to clone repo 
SSHURL="ssh.domain.com"
URL="$1"

echo "** creating tmp repo"
mkdir proto
cd proto
git init 
touch INITIAL
git add INITIAL
git commit -a -m "Initial Commit"

echo "** creating bare repo"
cd ..
git clone --bare proto proto.git
mv proto proto.old
git clone proto.git
rm -rf proto.old

echo "** generating hook"
HOOK=proto.git/hooks/post-update

mv $HOOK /tmp
echo '#!/bin/sh' >> $HOOK
echo '# To enable this hook, make this file executable by "chmod +x post-update".' >> $HOOK
echo '#exec git-update-server-info' >> $HOOK
echo '' >> $HOOK
echo '' >> $HOOK
echo 'URL='"$URL" >> $HOOK
echo 'PROTO="/home/$USER/www/$URL/proto"' >> $HOOK
echo 'PUBLIC="/home/$USER/www/$URL/public"' >> $HOOK
echo  '' >> $HOOK
echo 'export GIT_DIR="$PROTO/.git"' >> $HOOK
echo 'pushd $PROTO > /dev/null' >> $HOOK
echo 'git pull' >> $HOOK
echo 'popd > /dev/null' >> $HOOK
echo '' >> $HOOK
echo "echo -----------------------------" >> $HOOK
echo "echo '** Pushing changes to '$URL" >> $HOOK
echo "echo '** Moving current public to /tmp'" >> $HOOK
echo 'mv "$PUBLIC" "/tmp/'$URL'public-`date '+%m%d%Y'`"' >> $HOOK
echo 'echo "** Generating new public"' >> $HOOK
echo 'jekyll "$PROTO" "$PUBLIC"' >> $HOOK

echo "** enabling hook"
chmod a+x $HOOK 

echo "** clone repo on local machina. example:"
echo "git clone ssh://$USER@$SSHURL/~$USER/www/$SSHURL/proto.git"

