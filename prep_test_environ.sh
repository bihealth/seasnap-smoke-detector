#!/usr/bin/env bash

target="$1"
seasnap="$2"
source="dataset/"

if [[ -z "$target" || -z "$seasnap" ]] ; then
  echo "Usage: $0 <test directory> <seasnap dir>"
  exit 1
fi

echo "Creating test directory $target"
mkdir "$target" || exit 1

echo "Running sea-snap working_dir --dirname $target/out_mapping --configs mapping"
"$seasnap"/sea-snap.py working_dir --dirname "$target"/out_mapping --configs mapping || exit 1

echo "Running sea-snap working_dir --dirname $target/out_DE --configs DE"
"$seasnap"/sea-snap.py working_dir --dirname "$target"/out_DE --configs DE || exit 1

echo "Linking $source/input to $target/out_mapping/input"
ln -s $(realpath $source/input --relative-to=$target/out_mapping) $target/out_mapping/ || exit 1

echo "Linking $source/meta to $target/meta"
ln -s $(realpath $source --relative-to=$target)/meta $target/meta || exit 1

echo
echo Copying default config and covariate files.
echo You can use them as is, but better is to use them
echo as reference only and actually use the ones that
echo the seasnap you are testing has created.

mv $target/out_mapping/mapping_config.yaml $target/out_mapping/mapping_config.yaml_orig
mv $target/out_DE/DE_config.yaml $target/out_DE/DE_config.yaml_orig
cp $source/files/mapping_config.yaml $target/out_mapping/ || exit 1
cp $source/files/DE_config.yaml $target/out_DE/ || exit 1
cp $source/files/covariate_file.txt $target/out_DE/ || exit 1

echo "All seems to be OK until now."
