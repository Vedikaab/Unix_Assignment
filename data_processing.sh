#!/bin/bash

# Iterate through chromosome
for i in {1..10}; do
    # Sort the snp_position.txt file by chromosome and retain 1,3 and 4 column
    awk -v chr="$i" '$3 == chr'  snp_position.txt | cut -f 1,3,4 > sorted_chr_${i}.txt
   
    # Join the sorted_chr{i}.txt with the transposed genotype file considering the common snp_id
    join -t $'\t' -1 1 -2 1 sorted_chr_${i}.txt transposed_maize_genotypes.txt > joined_${i}.txt
   
    # Sort by position 
    sort -k3,3n joined_${i}.txt > chromosome_${i}.txt
   
    # Clean up
    rm sorted_chr_${i}.txt joined_${i}.txt
done
