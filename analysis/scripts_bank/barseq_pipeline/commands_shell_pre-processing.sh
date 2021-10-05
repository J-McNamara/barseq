# Shell commands to pre-process files

# Subset the first 1000 sequences to test
head -n 100 fastq_outfile.txt > fastq_outfilehead.txt

# Get lines after name | remove name line | remove spacer | word / line count
grep @SR -A 1 fastq_outfile.txt | grep -v @SRR | sed -n 'p;n' | wc

# Get lines after name | remove name line | remove spacer 
grep @SR -A 1 fastq_outfile.txt | grep -v @SRR | sed -n 'p;n' > stripped_reads.txt

# Subset only my reads - not PhiX reads
grep GTCGACCTGCAGCGTAC reads.txt >> matches.txt
grep -v GTCGACCTGCAGCGTAC reads.txt >> nonmatches.txt

# Aggregate indentical reads
# output | sort because uniq only takes consecutive | summarize frequencies >> write to file
cat outputs/aggregating_reads.txt | sort | uniq -c >> read_frequencies.txt

# Sum up uniq tables from different inputs

# Infinite loop that adds more to the text file. Bad idea!
cat stripped_reads.txt >> stripped_reads.txt

# 12:29 started unq on the data
# 13 seconds to sort and uniq 1M reads
# Nice
# Then just match labels to these and dont worry about assigning everything. Keep the seqs right in the dataframe
