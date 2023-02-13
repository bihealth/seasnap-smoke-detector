#!/usr/bin/env bash

if [ -z "$1" ] ; then
  echo "Usage: $0 <test_dir>"
  exit 0
fi

testdir="$1"

cd "${testdir}/out_DE" || exit 1

echo "Checking configuration with sea-snap DE l -np"
./sea-snap DE l -np > "DE_check.out"

if grep "Error" DE_check.out ; then
  echo There was a problem checking the yaml configuration.
  echo Check the file ${testdir}/out_DE/DE_check.out for details.
  exit 1
else
  echo "configuration appears OK"
fi

echo "Submitting job using sea-snap DE --submit slurm c"
./sea-snap DE --submit slurm c

echo "Submitted. I guess. Please check the output files."
