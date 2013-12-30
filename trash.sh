#!/bin/sh

# Given I 'rm [-f]' on file
# And changed my mind and want the file back
# Then I should be bale to get file back as-is (w/o overwriting any newly file thats ambiguous)

# Scrap object
function Scrap__main () {
  echo "main."
}

  # before/after filters, must be private/protected TODO
  function Scrap__before () {
    export SCRAP=declare -a ("/tmp/ke" "/tmp/k9")
    log "Added $SCRAP"
    $(export|wc -l)
  }

  function Scrap__after () {
      
      #echo "scrapped = $scrapped"
      #echo "bin = $bin"
    }
  }

  function Scrap__rm () {
    echo Scrap__after
  }

  function Scrap__params () {
    local TRASH = "$HOME/.scraped"
    local bin = `/usr/bin/rm`
  }

  function Scrap__list () {
  : "$1" :=$archive
    Scrap__params "$archive"
  }

exit 1

echo "oh nooooooooooo"
exit 1
#
# compile script:
#   namespace script. add " [Name]__" to each line
#   lint: make sure only 1 [Name] per class
#   compatible typescript, benchmark, export to zsh/bsh
#   dependency checks


trap Scrap__after
