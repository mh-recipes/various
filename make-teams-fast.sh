#!/usr/bin/env bash
LOC=$HOME'/Library/Application Support/Microsoft/Teams'
PROC='Microsoft Teams'

echo "* Killing $PROC ..." 
  pkill -x $PROC
  sleep 2
echo "* Wiping: $LOC ..." 
  rm -rf "$LOC"
echo "* Starting $PROC ..."
  open -a "$PROC"
