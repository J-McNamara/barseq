#setwd("C:/Users/Josh/OneDrive - Johns Hopkins/barseq_pipeline")

# Load my in-line experiment IDs
exp_id <- c('atatga', 'cttatg', 'taatct', 'gcgcga', 'agagca', 'tgcctt', 'ctactc', 'tcgtct', 'gaacat', 'cctatg', 'taatgg', 'gtgccg', 'cggcaa', 'gccgta', 'aaccat', 'ggttgc', 'ctaatg')
exp_id <- c('atatga', 'cttatg', 'taatct')
# Load the MoBY barcodes
barcode <- read.csv("barcode_list.csv")
barcode <- as.character(barcode[,1])
barcode <- head(barcode, 3)
# Illumina quality score
qualchars <- c('!', '"', '#', '$', '%', '&', '\'', '(', ')', '*', '+', ',', '-', '.', '/', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ':', ';', '<', '=', '>', '?', '@', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I')
# How many reads to simulate?
reads <- 2e3
# 1e4 = 2 Mb

# Make a list of simulated reads from the barcodes based on the seq amplicon
simulated_reads <- NULL
for (i in 1:reads){
  simulated_reads <- append(simulated_reads, paste('GTCGACCTGCAGCGTAC', sample(x=barcode,1), 'AGAGACCTCGTGGACATC', sample(exp_id,1), sep = ''))
}

# Clear the document
cat('', file="fastq_outfile.txt", append = FALSE)

# Write the simulated reads to the output file
for (i in 1:length(simulated_reads)){
  
  len <- nchar(simulated_reads[i])
  line <- paste("@SRR1299100.1.", i, ' ', i, " length= ", len, sep = "")
  # Paste the read header
  cat(line, file="fastq_outfile.txt",sep="\n", append = TRUE)
  # Paste the read
  cat(simulated_reads[i], file="fastq_outfile.txt",sep="\n", append = TRUE)
  # Paste the quality score head
  line <- paste("+SRR1299100.1.", i, ' ', i, " length= ", len, sep = "")
  cat(line, file="fastq_outfile.txt", sep="\n", append = TRUE)
  # Paste the quality score
  cat(paste(sample(qualchars, len, replace = TRUE), collapse = ''), file="fastq_outfile.txt",sep="\n", append = TRUE)
 }
# Demultiplex


