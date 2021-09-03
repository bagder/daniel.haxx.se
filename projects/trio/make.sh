#!/bin/sh
PATH="${PATH}:/home/dast/bin:/usr/local/bin"

export PATH

echo "update from CVS"
cvs -Q up -dP >/dev/null

echo "run make"
make -s --no-print-directory

