#The file documents how to change the fasta file headers with a new text file.
#The new header contains two parts: 1) gi|530643790|ref|XM_005308521.1| 2) the gene name from the last parathesis

#get the second part of the headers
grep ">" CPI_rna.fas | awk -F "[()]" '{ for (i=2; i<NF; i+=2) array[$1]=$i; print array[$1] }' > test2.txt


#get the first part of the header: delete everything after "PREDICTED:"
grep ">" CPI_rna.fas | sed 's/PREDICTED:.*//g' > test3.txt

#put them together
paste test3.txt test2.txt | sed 's/[\t ]//g' > test4.txt

#change from multiple line sequence fasta to one line sequence fasta
awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' < CPI_rna.fas > CPI_rna_oneline.fas

#replace fasta headers with another name in a text file
awk 'NR%2==0' CPI_rna_oneline.fas | paste -d'\n' test4.txt - > CPI_rna_newHeader.fas