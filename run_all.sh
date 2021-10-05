#!/bin/bash

# Re-run all analyses from raw data

echo Calling pre-processing script
cd analysis/preprocessing
./preprocessing.sh
echo Pre-processing done

echo Calling analysis script
cd ../analysis_notebook
r barseq_notebook.Rmd
echo Analysis script done
