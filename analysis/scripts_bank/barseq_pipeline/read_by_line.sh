# This script processes the fastq file line-by-line and removes all read names and quality scores
# This could be done in R, but it is probably much faster to do it at the shell

while IFS= read -r line
do
    echo "grepping"
    grep -A 4 '@'
    echo "grepped"

  echo "$line"
done

#< < (command)




#while IFS= read -r line
#do
   ## take some action on $line
#  echo "$line"
#done < <(ps aux)


#sample some lines
#grep -A 2 'keyword' /path/to/file.log
#grep -A 2 'keyword' /path/to/file.log
