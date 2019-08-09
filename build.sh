#!/bin/sh

# Check input specified
if [ -z "$1" ]; then
  echo "No input file given.";
  exit 1;
fi

# Options
INFILE="src/$1.sfd"
OUTFILE="output/$1.otf"
TESTDIR="test/font"

# Generate incorporating common feature file
echo ""
echo "Building feature: src/zlm.fea"

lsc tools/zlm.fea.ls > src/zlm.fea

# Generate incorporating common feature file
echo ""
echo "Building font: $INFILE -> $OUTFILE"
echo ""

fontforge -lang=ff -script build.pe $1

# Copy generated file to update test page
if [ "$2" == "--update-test" ]; then
  echo ""
  echo "Copying generated font to test dir: $OUTFILE -> $TESTDIR/$1.otf"
  echo ""
  cp $OUTFILE $TESTDIR
fi

