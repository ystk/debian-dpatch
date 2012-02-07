#!/bin/bash
# run the tests
# see ./README for details.

set -e
export TESTDIR=$(mktemp -d)
export PKGPATH="$TESTDIR/dpatch-test"
export LANG=C 
export LC_ALL=C
export SOURCE_DIR=$(pwd)

(
set -ex
run_test () {
    echo $1
    chmod a+x $1
    (
    sed -n 's/^##:/  /p' < $1
    echo 
    if ./$1 2>&1; then
	echo [OK] $1 >> test.log.summary
    else
	echo [FAIL] $1 >> test.log.summary
    fi
    ) | tee log/$1.tmp

    # process /tmp/XXX/ dir pathnames so that we have consistent log output
    # every time; helps to have a consistent output.
    sed -e's,/tmp/[^/]*/,/tmp/XXXX/,g' < log/$1.tmp > log/$1.log
    rm log/$1.tmp
}
: > test.log.summary

install -d log/

for TEST in [0-9][0-9]_*.sh; do
    run_test "$TEST"
done

rm -r "$TESTDIR"
)
