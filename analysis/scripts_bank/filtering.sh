#!/bin/bash

SECONDS=0

#get stripped trimmed reads | head for test brevity | fuzzy grep for leader sequence, tolerate 3 mismatches | cut off leader seq | grep for tail seq and tolerate 3 mismatches | reverse seq | cut off first 25 bases | reverse back | grep for seq between barcodes  | replace seq between barcodes with a tab | sort aphabetically for uniq | translate to complement | reverse the complement | aggregate unique cases | sort unique cases high to low freq, -n read numbers as numeric

mkdir -p output

cat ../02_strip_trim_no-aggregate/output/barseq.fastq.strip.trim.unq | agrep -3 '^ GTCGACCTGCAGCGTACG' |  cut -c 19- | agrep -3 'ATCTCGTATGCCGTCTTCTGCTTG$' | rev | cut -c25- | rev | grep AGAGACCTCGTGGACATC  | sed "s/AGAGACCTCGTGGACATC/\t/g" | tr ACGTacgt TGCAtgca | rev | sort| uniq -c | sort -rn > output/barseq.fastq.strip.trim.pare2.unq

echo $SECONDS
