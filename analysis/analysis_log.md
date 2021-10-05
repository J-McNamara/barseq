# Barcode sequencing notebook

## Retrieve data and set up repos
### Download files via FTP with FileZilla
	Host:
	sftp://sftp.genewiz.com
	User:
	mcnamara_jhmi
	Password:
	7HhkoKSDHf1WYxq5NWeA
	Port
	22
## Decompress files with gnu archive utility gui
- There are two data files 
- Extract in place
- Too large for hard drive, extract one at a time and delete source

sudo apt install exfat-utils

Make an exFAT disk external hd to backup the data
This doesnt have file size limits and is readable on linux mac windows

I might be able to pipe through tar and discard all the headers and qual scores

```
gzip filesname -k
gzip filesname -dk
```

10000 lines is 900 kb
Gzip got it to 195 kb

file sizes are
35.2 Gb 
44.3 Gb

Unzipped probably are 
~4.6 x bigger ~
161.92
203.78
365.7 Gb total
Estimated 
33 billion reads?
WOW! Cant be correct

Unzipping and stripping took a 195 kb file | 900 kb file | 377 kb file

Not bad
2x expansion

Need to figure out how to use git for this
uinq did not compress the files appreciably, actually larger
Maybe compression would be better if the filesize were larger

for 3 million there are many 10s and the aggregated form is in fact smaller:
cat test.fastq.gz.strip.unq | sort | head -n 20
```
     10 AAAAAAAGTTTGAATTATGGCGAGAAATAAAAGTCTGAAACATGATTAAACTCCTAAGCAGAAAACCTACCGCGCTTCGCTTGGTCAACCCCTCAGCGGCAAAAATTAAAATTTTTACCGCTTCGGCGTTATAACCTCACACTCAATCTT
     10 AAAACGTCGGCTACAGTAACTTTTCCCAGCCTCAATCTCATCTCTCTTTTTGCGTTCTGCTTCAATATCTGGTTGAACGGCGTCGCGTCGTAACCCAGCTTGGTAAGTTGGATTAAGCACTCCGTGGACAGATTTGTCATTGTGAGCATT
     10 AAAACTGCGTAACCGTCTTCTCGTTCTCTAAAAACCATTTTTCGTCCCCTTCGGGGCGGTGGTCTATAGTGTTATTAATATCAAGTTGGGGGAGCACATTGTAGCATTGTGCCAATTCATCCATTAACTTCTCAGTAACAGATACAAACT
     10 AAAAGCCTCCAAGATTTGGAGGCATGAAAACATACAATTGGGAGGGTGTCAATCCTGACGGTTATTTCCTAGACAAATTAGAGCCAATACCATCAGCTTTACCGTCTTTCCAGAAATTGTTCCAAGTATCGGCAACAGCTTTATCAATAC
     10 AAACCATAACGAGCATCATCTTGATTAAGCTCATTAGGGTTAGCCTCGGTACGGTCAGGCATCCACGGCGCTTTAAAATAGTTGTTATAGATATTCAAATAACCCTGAAACAAATGCTTAGGGATTTTATTGGTATCAGGGTTAATCGTG
     10 AAACTCAACAGGAGCAGGAAAGCGAGGGTATCCTACAAAGTCCAGCGTACCATAAACGCAAGCCTCAACGCAGCGACGAGCACGAGAGCGGTCAGTAGCAATCCAAACTTTGTTACTCGTCAGAAAATCGAAATCATCTTCGGTTAAATC
     10 AAACTCCTAAGCAGAAAACCTACCGCGCTTCGCTTGGTCAACCCCTCAGCGGCAAAAATTAAAATTTTTACCGCTTCGGCGTTATAACCTCACACTCAATCTTTTATCACGAAGTCATGATTGAATCGCGAGTGGTCGGCAGATTGCGAT
     10 AAACTTTGTTACTCGTCAGAAAATCGAAATCATCTTCGGTTAAATCCAAAACGGCAGAAGCCTGAATGAGCTTAATAGAGGCCAAAGCGGTCTGGAAACGTACGGATTGTTCAGTAACTTGACTCATGATTTCTTACCTATTAGTGGTTG
     10 AAAGGACTTCTTGAAGGTACGTTGCAGGCTGGCACTTCTGCCGTTTCTGATAAGTTGCTTGATTTGGTTGGACTTGGTGGCAAGTCTGCCGCTGATAAAGGAAAGGATACTCGTGATTATCTTGCTGCTGCATTTCCTGAGCTTAATGCT
     10 AAATCTGCCATTCAAGGCTCTAATGTTCCTAACCCTGATGAGGCCGTCCCTAGTTTTGTTTCTGGTGCTATGGCTAAAGCTGGTAAAGGACTTCTTGAAGGTACGTTGCAGGCTGGCACTTCTGCCGTTTCTGATAAGTTGCTTGATTTG
     10 AAATGCCGCGGATTGGTTTCGCTGAATCAGGTTATTAAAGAGATTATTTGTCTCCAGCCACTTAAGTGAGGTGATTTATGTTTGGTGCTATTGCTGGCGGTATTGCTTCTGCTCTTGCTGGTGGCGCCATGTCTAAATTGTTTGGAGGCG
     10 AAATTGTTCCAAGTATCGGCAACAGCTTTATCAATACCATGAAAAATATCAACCACACCAGAAGCAGCATCAGTGACGACATTAGAAATATCCTTTGCAGTAGCGCCAATATGAGAAGAGCCATACCGCTGATTCTGCGTTTGCTGATGA
     10 AAATTGTTTGGAGGCGGTCAAAAAGCCGCCTCCGGTGGCATTCAAGGTGATGTGCTTGCTACCGATAACAATACTGTAGGCATGGGTGATGCTGGTATTAAATCTGCCATTCAAGGCTCTAATGTTCCTAACCCTGATGAGGCCGTCCCT
     10 AAATTTGAGCAGATTTGTCGTCACAGGTTGCGCCGCCAAAACGTCGGCTACAGTAACTTTTCCCAGCCTCAATCTCATCTCTCTTTTTGCGTTCTGCTTCAATATCTGGTTGAACGGCGTCGCGTCGTAACCCAGCTTGGTAAGTTGGAT
     10 AACAAAGAAACGCGGCACAGAATGTTTATAGGTCTGTTGAACACGACCAGAAAACTGGCCTAACGACGTTTGGTCAGTTCCATCAACATCATAGCCAGATGCCCAGAGATTAGAGCGCATGACAAGTAAAGGACGGTTGTCAGCGTCATA
     10 AACACTACTGGTTATATTGACCATGCCGCTTTTCTTGGCACGATTAACCCTGATACCAATAAAATCCCTAAGCATTTGTTTCAGGGTTATTTGAATATCTATAACAACTATTTTAAAGCGCCGTGGATGCCTGACCGTACCGAGGCTAAC
     10 AACCCTAATGAGCTTAATCAAGATGATGCTCGTTATGGTTTCCGTTGCTGCCATCTCAAAAACATTTGGACTGCTCCGCTTCCTCCTGAGACTGAGCTTTCTCGCCAAATGACGACTTCTACCACATCTATTGACATTATGGGTCTGCAA
     10 AACCGCATCAAGCTCTTGGAAGAGATTCTGTCTTTTCGTATGCAGGGCGTTGAGTTCGATAATGGTGATATGTATGTTGACGGCCATAAGGCTGCTTCTGACGTTCGTGATGAGTTTGTATCTGTTACTGAGAAGTTAATGGATGAATTG
     10 AACCTCAGCACTAACCTTGCGAGTCATTTCTTTGATTTGGTCATTGGTAAAATACTGACCAGCCGTTTGAGCTTGAGTAAGCATTTGGCGCATAATCTCGGAAACCTGCTGTTGCTTGGAAAGATTGGTGTTTTCCATAATAGACGCAAC
     10 AACGCCCTCTTAAGGATATTCGCGATGAGTATAATTACCCCAAAAAGAAAGGTATTAAGGATGAGTGTTCAAGATTGCTGGAGGCCTCCACTATGAAATCGCGTAGAGGCTTTGCTATTCAGCGTTTGATGAATGCAATGCGACAGGCTC
```

About 1 min for the 10M reads

##


fasta.gz.strip (not really a gz file) for 10M reads = 377 Mb
fasta.gz.strip.unq 321.3 Mb
Starting to see some compression

30M reads? about 1 min.
===

2020-11-13

- Reorganized the directory structure and checked on the file archiving. OneNote not working.
- Continued testing read aggregation program
- Set up git for version control and scripting / analysis backup

Took a while to get the processing script going in the new data format but it is more portable due to relative paths, can run elsewhere.

### 30M reads logfile: 

```
wc for input =  30000000
wc for stripped file
   7500000    7500000 1132500000 output/test.fastq.strip
wc for stripped unique file
  5960318  11920636 947690562 output/test.fastq.strip.unq
--------------
Stripped size:
1105964   output/test.fastq.strip
Stripped unique size:
925484    output/test.fastq.strip.unq

Seconds to run script:
469
```
About 8 minutes
64k reads per minute
not too much aggregation happening
only 2x size of archive though 

This is doable for the whole dataset
===

There seem to be alot of 100 seq identities aggregated. Is this the cap for the uniq function? 
Ran this:
`cat test.fastq.strip.unq | sort | uniq -c > re-uniq.fasta`
To test of any of the uniqs were not uniq
Can multiply the prefixes later

```
-f, --skip-fields=N
              avoid comparing the first N fields

           Note: 'uniq' does not detect repeated lines unless they  are  adjacent.
  You  may want to sort the input first, or use 'sort -u' without 'uniq'.
  Also, comparisons honor the rules specified by 'LC_COLLATE'.
```

```
ubu@ubu1:~/barseq/analysis/02_aggregate_reads/output$ wc re-uniq.fasta 
  5960318  17880954 995373106 re-uniq.fasta
ubu@ubu1:~/barseq/analysis/02_aggregate_reads/output$ wc test.fastq.strip.unq 
  5960318  11920636 947690562 test.fastq.strip.unq
```

most reads are unique
sorting is by their count number but in a weird way so a bunch of 100s will be in a row etc


Compress the compressed files together to test size for L drive storage
`tar -czvf ~/barseq/analysis/compression-test.tar.gz ~/barseq/raw_data`

Tarred together was 77Gb, no savings

Could probably drop read 2


## Overrepresented sequences:

GTCGACCTGCAGCGTACGGATTAAGGTAACTGCCGTCGCAGAGACCTCGT     4544794   1.045048689680177   No Hit   Mhf1
GTCGACCTGCAGCGTACGGGGTGTTCGACATGCTCTTCAGAGACCTCGTG     1064817   0.24484841570358898 No Hit   MIA40
GTCGACCTGCAGCGTACGCGTAAGTCTGTAGAGCTATGAGAGACCTCGTG     1027948   0.23637060567747595 No Hit   PPZ1
GTCGACCTGCAGCGTACGCTAGCATGTAGTCACAGGTGAGAGACCTCGTG     853012    0.1961450998398315  No Hit   Lcb1 
GTCGACCTGCAGCGTACGCCCTAAATGCTCAAACAGAGAGAGACCTCGTG     798292    0.1835625571988891  No Hit
GTCGACCTGCAGCGTACGCTTGCGCGGAATGTAGTTCTAGAGACCTCGTG     507910    0.11679092165133528 No Hit
GTCGACCTGCAGCGTACGCGTCGAAATTGTACTTGGGCAGAGACCTCGTG     485823    0.11171214571364348 No Hit
GTCGACCTGCAGCGTACGGATTCCCAGCCTGTGCTAATAGAGACCTCGTG     478074    0.10993030867189162 No Hit
GTCGACCTGCAGCGTACGGTGCTGGGTTCGCATTCATCAGAGACCTCGTG     440297    0.10124370937827169 No Hit




---
Going back through the data processing trying to figure it out 
I think what I realized was that its easier to do filtering before uniquing beacuse it is tough to add the unqs

but it is easier to do the strip and read first

Maybe make a new script that does everything from the inital file, then has a second command that 



I can cut out the strip trim, as the later grep is going to pull it out

so do later grep right out, trim, filter
then do inverse grep strip trim uniq no filter

## Benchmarking on the macbook
pre-processing 10M reads
file hash check took 6 seconds
preprocessing took 94 seconds
doing the whole thing probably takes 2 hr
2x longer than intel desktop 

