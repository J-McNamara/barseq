#setwd("C:/Users/Josh/OneDrive - Johns Hopkins/barseq_pipeline")
library(readxl)
key <- read_xlsx('moby_key2.xlsx')


#filepath <- "C:/Users/Josh/OneDrive - Johns Hopkins/barseq_pipeline/fastq_outfile.txt"
filepath <- "/Users/JTM/Desktop/OneDrive - Johns Hopkins/barseq_pipeline/fastq_outfile.txt"

# Read file line-by-line
'''
# Define line-by-line function
processFile = function(filepath) {
  con = file(filepath, "r")
  while ( TRUE ) {
    line = readLines(con, n = 1)
    if ( length(line) == 0 ) {
      break
    }
 
    # Do something to line here
    #print(grep(pattern = 'GTCGACC', x = line, ignore.case = TRUE, value = TRUE))
    #cat(simulated_reads[i], file="fastq_outfile.txt",sep="\n", append = TRUE)
        }
  
  close(con)
}
# Execute line-by-line function
processFile(filepath)
'''

# Load all reads to memory for processing
reads <- read.table("stripped_fastq.txt", )
reads[1,]
key

if (grep("GCG", reads[1.]) != character(0)){
  print('foo')
}

})


# Summarize the data 
a <- c("GTCGACCTGCAGCGTACAAAGAAATACCCGGCCCTGGAGAGACCTCGTGGACATCctaatg", "GTCGACCTGCAGCGTACAAAGAAATACCCGGCCCTGGAGAGACCTCGTGGACATCctaatg", "GTCGACCTGCAGCGTACAAAGAAATACCCGGCCCTGGAGAGACCTCGTGGACATCctaacg", "GTCGACCTGCAGCGTACAAAGAAATACCCGGCCCTGGAGAGACCTCGTGGACATCctaatg")
data.frame(table(a))

