#!/bin/sh

# Given I 'rm [-f]' on file
# And changed my mind and want the file back
# Then I should be bale to get file back as-is (w/o overwriting any newly file thats ambiguous)

# Scrap object
function Scrap__Bootstrap () {
  scrap__before
  export X_params = $(export | wc -l)
  log "11: $X_params"
}

function Scrap__main () {
  echo $vars

}

  # before/after filters, must be private/protected TODO
  function Scrap__before () {
    export SCRAP=declare -a ("/tmp/ke" "/tmp/k9")
    log "Added $SCRAP"
    log
    $(export|wc -l)
  }

  function Scrap__after () {
      $vars = $(export | wc -l)
      echo "scrapped = $scrapped"
      echo "bin = $bin"
    }
  }

  function Scrap__rm () {
    #echo Scrap__after
  }

  function Scrap__params () {
    local TRASH = "$HOME/.scraped"
    local bin = `/usr/bin/rm`
  }

  function Scrap__list () {
#: "$1" :=$archive
    local env="$1"
    echo Scrap__params "$env"
    echo "-------"
  }

exit 0

# compile script:
#   namespace script. add " [Name]__" to each line
#   lint: make sure only 1 [Name] per class
#   compatible typescript, benchmark, export to zsh/bsh
#   dependency checks


Scrap__main
Scrap__rm
Scrap__list

trap Scrap__after
