#!/bin/bash

##############################
### Pre-process BARSEQ data
##############################
#
# Josh McNamara, Johns Hopkins University, 2020
#
####################
### Description
#####################
#
# The script takes a fastq.gz compressed sequence as an input and outputs a tab separated (.tsv) file with the read count, experiment index, and gene barcode.
#
# Example:
# count 	index	barcode
# 23425234	CATGCT	GTATCGATTCGGATCTCGAT 
# 
# Output is delivered in a new directory titled 'output' in the current directory.
# For large files with redundancy, output file should be much smaller than input file
#
# The script takes ~1 hour to process a 30 Gb fastq.gz file on a 2016 4-core Lenovo Thinkcentre desktop with 8 Gb memory, outputting a ~100 Mb file
#
##############################


####################
### Inputs
####################

# Strip the gz suffix (last 3 char) from the input filename                                                                                                      
infile='../../raw_data/barseq-001_R1_001.fastq.gz'
hash='cd85574cdc0b41cb02f798421d3f09b4'

####################
### Setup
####################

# Initialize the timer
SECONDS=0

# Make output directory, -p if it does not already exist
mkdir -p output

# Name the output file
outfile='output/barseq_counts.tsv'
echo 'count	id	barcode' > $outfile

# Start a logfile
echo | tee $outfile.log # Write to terminal and create logfile
echo '====================' | tee -a $outfile.log # Write to terminal and append to logfile
echo 'BARSEQ pre-processing start' | tee -a $outfile.log 
echo '====================' | tee -a $outfile.log

# Check the integrity of the input file and write to logfile
echo  | tee -a $outfile.log
echo 'Checking input file integrity' |  tee -a $outfile.log
echo '----------' | tee -a $outfile.log
echo 'md5sum hash should equal:' | tee -a $outfile.log
echo $hash | tee -a $outfile.log
echo 'Input file hash is:' |  tee -a $outfile.log
infile_hash=$(md5 $infile) # Check the hash of the input file. The command is 'md5' on OSX, and should be replaced with 'md5sum' in a standard version of bash.
#infile_hash=$(head -n 1000000 $infile | md5 ) # Uncomment to only hash first 1M lines
echo $infile_hash | tee -a $outfile.log
echo Checking the hash took $SECONDS seconds. | tee -a $outfile.log
echo  | tee -a $outfile.log


####################
### Count the barcodes
####################
# This entire code block is a pipe to the output file
gunzip -ckd $infile | # Unzip the compressed raw data and send line-by-line to terminal. -c write to stdout, -k keep original file, -d decompress
#head -n 1000000 | # Uncomment this line to test the script on only the first 1M lines
agrep -3 '^GTCGACCTGCAGCGTACG' | # Select lines with the i7 sequence at the beginning of amplicon. agrep = approximate grep, -3 tolerate 3 mismatches, ^ = regex for beginning of line
cut -c19-86 | # Keep 19th-86th characters. This discards the primer sequence in the beginning and trims some sequence after the barcodes. Don't trim to the end of the barcodes yet because they have variable length
agrep -3 'ATCTCGTATGCCGTCTTCTGCTTG$' | # Search for the primer sequence 3' to the barcodes and tolerate 3 mismatches
rev | cut -c25- | rev |  # Reverse the line, discard the first 24 bases, and reverse the line back to discard the 3' primer sequence
grep AGAGACCTCGTGGACATC  | # Search lines for the forward primer sequence between the experiment index and the gene barcodes. We can only accept exact matches here because the next line replaces this sequence with a tab character
sed "s/AGAGACCTCGTGGACATC/\t/g" | # Replace the space between the barcodes 
tr ACGTacgt TGCAtgca | rev | # Take the reverse complement of the barcode sequences to put them in the same orientation as the library key
sort | # Sort the barcodes alphabetically so that identical reads are on adjacent lines
uniq -c | # Combine identical barcode reads, -c count how many copies of each and combine count and barcode into one line
grep -v ' 1 ' | # Only keep reads with 2 or more instances
sort -rn | # Sort the counted barcode reads by their frequency, -r descending order, -n sort by number
sed -e 's/^[ \t]*//' | # Get rid of leading whitespace that precedes the counts
tr ' ' '	' >> $outfile # Convert remaining spaces to a tab for .tsv format and write to output file specified above


####################
### Write missed reads to a file
####################
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

####################
### Finish the logfile
####################
echo | tee -a $outfile.log
echo File pre-processing took $SECONDS seconds. | tee -a $outfile.log
echo | tee -a $outfile.log





