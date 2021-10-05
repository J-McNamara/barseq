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
outfile='output/barseq.fastq'

#########
### Main function
# Unzip, strip metadata, trim lines, aggregate unique cases, sort unique cases by frequency, write to file
# unzip -c go to standard output -k keep orig file -d decompress | find @ in read name lines -A 1 keep the line after it | negative selection of @ lines | get rid of + and - spacers that grep adds | keep only characters 1-86 from each line | sort lines alphabetically so that unique can aggregate them | aggregate unique cases and output their count followed by identity | sort unique cases by thier frequency -r highest first -n use digits as numeric rather than 1 10 11 2 20 21 2... > write to file

gunzip -ckd $1 | grep @ -A 1 | grep -v @ | sed -n 'p;n'| cut -c1-86 | sort | uniq -c | sort -nr > $outfile.strip.trim.unq                                        

##########
### Build a logfile
#
echo 'WC for stripped, trimmed, unique file' > $outfile.log           
wc $outfile.strip.trim.unq >> $outfile.log
echo'' >> $outfile.log

echo -------------- >> $outfile.log
echo "Original raw file size:" >> $outfile.log                                                                                                        
du $1 >> $outfile.log                                                                                                                       
echo'' >> $outfile.log   

echo -------------- >> $outfile.log
echo "Stripped unique trimmed file size:" >> $outfile.log
du $outfile.strip.trim.unq >> $outfile.log
echo'' >> $outfile.log

echo -------------- >> $outfile.log
echo 'Aggregation summary' >> $outfile.log
head $outfile.strip.trim.unq >> $outfile.log
echo '' >> $outfile.log
 
echo -------------- >> $outfile.log
echo 'Seconds to run script:' >> $outfile.log
echo $SECONDS >> $outfile.log

echo "Done"
#########
