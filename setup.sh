#!/bin/sh
die() { echo "FATAL ERROR: $@" >&2; return 1
}
USAGE="USAGE:

    source $0 [SpArcFiRe Repo Directory]

This script does not change any files, but sets the environment variable SPARCFIRE_HOME to
the base of the SpArcFiRe repo---which is usually just the same directory this
file resides. If you give it an argument, it'll use that directory instead. Otherwise it'll
assume that it's own directory is the SpArcFiRe directory, and all it'll do is echo that
directory.
Note: the 'source' command assumes you're using bash as your shell; if not, you'll need
to figure out how to set the environment variable SPARCFIRE_HOME yourself.
"

echo "$USAGE"

echo -n "Checking you have Python 2.7 installed: "
python2.7 --version || die "You need to install Python 2.7, and have the executable called python2.7"
PIP_NEED='numpy|Pillow|scipy|astropy'
PIP_HAVE=`python2.7 -m pip list | egrep "$PIP_NEED"`
if [ `echo "$PIP_HAVE" | wc -l` -ne 4 ]; then
    echo "We need all of the following Python packages: `echo "$PIP_NEED" | sed 's/|/ /g'`"
    echo But you only have the following:
    echo "$PIP_HAVE"
    echo "Please use 'python2.7 -m pip install <package>' to install any missing packages"
    die "missing pip packages"
fi

MYDIR=`dirname $0`
MYDIR=`cd $MYDIR; /bin/pwd`
case $# in
0) export SPARCFIRE_HOME="$MYDIR" ;;
*) export SPARCFIRE_HOME="$1";;
esac

echo ""
echo SpArcFiRe repo is in "$SPARCFIRE_HOME"
echo "If you ran this script without the word 'source' before it, you messed up. Try again."
