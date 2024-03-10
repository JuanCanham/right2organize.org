#!/usr/bin/env bash
DIR="$( dirname "${BASH_SOURCE[0]}" )/"
ASPELL_CMD="aspell --mode=html --ignore=3 --home-dir=../${DIR}"
ACTION=$1

ERRORS=0

check_file(){
  if [[ "$ACTION" == "update" ]] ; then
    $ASPELL_CMD -l "$2" check "$1"
  else
    OUTPUT=$($ASPELL_CMD -l "$2" list < "$1")
    if [[ "$OUTPUT" ]] ; then
        echo "=== Errors in $1"
        echo "$OUTPUT"
        ((ERRORS++))
    fi
  fi
}


check_file html/index.html en_US

exit $ERRORS
