-File has 4 components
        @title
        <READ>
        +title (repeated)
        <QUALITY SCORE>
- Use bash shell script to discard all lines that are not sequences
        - Read line-by-line to avoid RAM limits
        - Any imperfect barcode read will be discarded, so low quality not important
        - Cuts file size by 75%
- Subset first 1000 reads for testing to minimize memory use
        - Test R script to match barcodes
        
        
- Use R script to assign barcodes
        - Do in memory on data processing machines
        - Faster and better data structures
        