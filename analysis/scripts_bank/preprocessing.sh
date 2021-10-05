#!/bin/bash

#########
### Pre-process barseq data
#
# The script takes an fastq.gz as an input file, outputs raw reads stripped of titles, quality score, fake reads after construct, and aggregates by unique reads
# Output is delivered in directory "output" in current directory
# For large files with redundancy, output file should be much smaller than input file
#
##########
### Setup
#
# Initialize timer
SECONDS=0

# Make output directory
mkdir -p output

# Strip the gz suffix (last 3 char) from the input filename                                                                                                      
infile='../raw_data/barseq-001_R1_001.fastq.gz'
outfile='output/barseq.strip.trim.filter.unq'

#########
### Main function
# Unzip, strip metadata, trim lines, aggregate unique cases, sort unique cases by frequency, write to file
# unzip -c go to standard output -k keep orig file -d decompress | find @ in read name lines -A 1 keep the line after it | negative selection of @ lines | get rid of + and - spacers that grep adds | keep only characters 1-86 from each line | sort lines alphabetically so that unique can aggregate them | aggregate unique cases and output their count followed by identity | sort unique cases by thier frequency -r highest first -n use digits as numeric rather than 1 10 11 2 20 21 2... > write to file

# Get hits
gunzip -ckd $infile | head -n 1000000 | agrep -3 '^GTCGACCTGCAGCGTACG' | cut -c19-86 | agrep -3 'ATCTCGTATGCCGTCTTCTGCTTG$' | rev | cut -c25- | rev | grep AGAGACCTCGTGGACATC  | sed "s/AGAGACCTCGTGGACATC/\t/g" | tr ACGTacgt TGCAtgca | rev | sort| uniq -c | sort -rn | grep -v ' 1 '  > $outfile

# Rescue misses
#gunzip -ckd $1  | grep @ -A 1 | grep -v @ | sed -n 'p;n'| cut -c1-86 | agrep -v3 '^ GTCGACCTGCAGCGTACG' |  cut -c 19- | agrep -3 'ATCTCGTATGCCGTCTTCTGCTTG$' | rev | cut -c25- | rev | grep AGAGACCTCGTGGACATC  | sed "s/AGAGACCTCGTGGACATC/\t/g" | tr ACGTacgt TGCAtgca | rev | sort| uniq -c | sort -rn > output/barseq.fastq.strip.trim.pare2.unq



# # Each phase
# n=1000000
# echo start
# gunzip -ckd $infile | head -n $n | wc

# echo first grep
# gunzip -ckd $infile | head -n $n | agrep -3 '^GTCGACCTGCAGCGTACG' | wc

# echo second grep
# gunzip -ckd $infile | head -n $n | agrep -3 '^GTCGACCTGCAGCGTACG' | cut -c19-86 | agrep -3 'ATCTCGTATGCCGTCTTCTGCTTG$' | wc

# echo third grep
# gunzip -ckd $infile | head -n $n | agrep -3 '^GTCGACCTGCAGCGTACG' | cut -c19-86 | agrep -3 'ATCTCGTATGCCGTCTTCTGCTTG$' | rev | cut -c25- | rev | agrep -2 AGAGACCTCGTGGACATC  | wc


# echo final
# gunzip -ckd $infile | head -n $n | agrep -3 '^GTCGACCTGCAGCGTACG' | cut -c19-86 | agrep -3 'ATCTCGTATGCCGTCTTCTGCTTG$' | rev | cut -c25- | rev | grep AGAGACCTCGTGGACATC  | sed "s/AGAGACCTCGTGGACATC/\t/g" | tr ACGTacgt TGCAtgca | rev | sort | wc



echo $SECONDS
echo $SECONDS > $outfile.log

