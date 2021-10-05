#!/bin/bash

# Shell commands to pre-process files

# Get lines starting @ and following line | remove name line starting @ | remove spacer | word / line count
inputfile='test.fastq.gz'
echo 'Total line count after unzipping'
gunzip -ckd $inputfile | wc
echo 'Line count after unzipping and stripping'
gunzip -ckd $inputfile | grep @ -A 1 | grep -v @ | sed -n 'p;n' | wc

