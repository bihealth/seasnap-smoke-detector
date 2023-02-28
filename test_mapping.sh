#!/usr/bin/env bash

if [ -z "$1" ] ; then
  echo "Usage: $0 <test_dir>"
  exit 0
fi

testdir="$1"

cd "${testdir}/out_mapping" || exit 1
./sea-snap sample_info

if [[ ! -f "sample_info.yaml" ]] ; then
  echo "Generating sample info failed." >&2
  exit 1
fi

echo "Checking configuration with sea-snap mapping l -np"
./sea-snap mapping l -np > "mapping_check.out"

if grep "Error" mapping_check.out ; then
  echo There was a problem checking the yaml configuration.
  echo Check the file ${testdir}/out_mapping/mapping_check.out for details.
  exit 1
else
  echo "configuration appears OK"
fi


echo "Submitting job using sea-snap mapping --submit slurm c"
./sea-snap mapping --submit slurm c

echo "Submitted. I guess. Please check the output files."
