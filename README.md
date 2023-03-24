# Smoke detector test for seasnap-pipeline

## Overview

The directory `dataset/` contains the test data set based on the GEO data
set GSE157103. Six samples from COVID patients and controls have been
selected in total, and only 250,000 paired reads were kept from each
sample.

## Preparation

Install the conda environments for seasnap.

Install the R package Rseasnap:

`remotes::install_github("bihealth/Rseasnap")`

## Instructions

 * make sure you have the environments seasnap-mapping and seasnap-de
 defined, preferably constructed with the yaml files from the seasnap
 version you wish to test
 * activate the seasnap-mapping environment
 * run the script `prep_test_environ.sh` giving it as the parameters
 the name of the test directory to create and to perform the test, and the
 location of the seasnap-pipeline directory you wish to test. It will
 link the necessary data to the test directory and create the structure for
 testing.
 * edit the config files as necessary. There are default yaml files
 provided, but the ones created by sea-snap are stored with the extension
 `_orig`, you might want to use them instead.
 * run `test_mapping.sh <test_dir>`. This is a shortcut to generate the
 sample info and start the seasnap pipeline on the cluster (`--submit
 slurm`). However, you might want to test alternatives.
 * check that the mapping pipeline finished its run without errors by
 looking at `<test_dir>/out_mapping/pipeline_log.err`.
 * switch to the DE environment (by default, seasnap-de).
 * run `test_DE.sh <test_dir>`.
