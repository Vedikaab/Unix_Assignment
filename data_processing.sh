#!/bin/bash

# Iterate through chromosome
for i in {1..10}; do
    # Sort the snp_position.txt file by chromosome and retain 1,3 and 4 column
    awk -v chr="$i" '$3 == chr'  snp_position.txt | cut -f 1,3,4 > sorted_chr_${i}.txt
   
    # Join the sorted_chr{i}.txt with the transposed genotype file considering the common snp_id
    join -t $'\t' -1 1 -2 1 sorted_chr_${i}.txt transposed_teosinte_genotypes.txt > joined_${i}.txt
   
    # Sort by position in increasing order 
    (echo -e "SNP_ID\tChromosome\tPosition\tGenotype" && sort -k3,3n joined_${i}.txt) > chromosome_increasing${i}.txt
 
    # Sort by position in decreasing order with '?' replaced by '-'
    (echo -e "SNP_ID\tChromosome\tPosition\tGenotype" && sort -k3,3nr joined_${i}.txt | sed 's/?/-/g') > chromosome_decreasing${i}.txt
   
done

   

   #For multiple 

   awk -v chr='multiple' '$3 == chr|| $4 == chr' snp_position.txt | cut -f 1,3,4 > sorted_chr_multiple.txt

   join -t $'\t' -1 1 -2 1 sorted_chr_multiple.txt transposed_teosinte_genotypes.txt > joined_multiple.txt

   (cat <(echo -e "SNP_ID\tChromosome\tPosition\tGenotype") && cat joined_multiple.txt) > chromosome_multiple.txt

   #For unknown
   awk -v chr='unknown' '$3 == chr|| $4 == chr' snp_position.txt | cut -f 1,3,4 > sorted_chr_unknown.txt

   join -t $'\t' -1 1 -2 1 sorted_chr_unknown.txt transposed_teosinte_genotypes.txt > joined_unknown.txt
   
   (cat <(echo -e "SNP_ID\tChromosome\tPosition\tGenotype") && cat joined_unknown.txt) > chromosome_unknown.txt

   # Clean up
   rm sorted_chr* joined*
