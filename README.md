# UNIX Assignment

## Data Inspection

### Attributes of `fang_et_al_genotypes`

Here is my snippet of code used for data inspection
```
wc fang_et_al_genotypes.txt

awk -F "\t" '{print NF; exit}' fang_et_al_genotypes.txt

du -h fang_et_al_genotypes.txt

```
By inspecting this file I learned that:

1. The .txt file contains 2744038 words, 2783 lines, and 11051939 characters.
2. The .txt file contains 986 number of columns.
3. The .txt file size is 6.7M


### Attributes of `snp_position.txt`

Here is my snippet of code used for data inspection
```
wc snp_position.txt

awk -F "\t" '{print NF; exit}' snp_position.txt

du -h snp_position.txt

```
By inspecting this file I learned that:

1. The .txt file contains 984 lines, 13198 words and 82763 charcters.  
2. The .txt file contains 15 number of columns.
3. The .txt file size is 49k. 


## Data Processing

### Maize Data

Here is my snippet of code used for data processing
```
awk 'NR==1 || /ZMM/' fang_et_al_genotypes.txt | cut -f 4-986 > maize_genotypes.txt

awk -f transpose.awk maize_genotypes.txt > transposed_maize_genotypes.txt

sh data_processing.sh

# Here is the snippet of the slurm file

#!/bin/bash

# Iterate through chromosome 

for i in {1..10}; do 

awk -v chr="$i" '$3 == chr' snp_position.txt | cut -f 1,3,4 > extracted_chr_${i}.txt

join -t $'\t' -1 1 -2 1 extracted_chr_${i}.txt transposed_maize_genotypes.txt > joined_${i}.txt

(echo -e "SNP_ID\tChromosome\tPosition\tGenotype" && sort -k3,3n joined_${i}.txt) > chromosome_increasing${i}.txt

(echo -e "SNP_ID\tChromosome\tPosition\tGenotype" && sort -k3,3nr joined_${i}.txt | sed 's/?/-/g') > chromosome_decreasing${i}.txt

done

# For multiple

awk -v chr='multiple' '$3 == chr|| $4 == chr' snp_position.txt | cut -f 1,3,4 > extracted_chr_multiple.txt

join -t $'\t' -1 1 -2 1 extracted_chr_multiple.txt transposed_maize_genotypes.txt > joined_multiple.txt

(cat <(echo -e "SNP_ID\tChromosome\tPosition\tGenotype") && cat joined_multiple.txt) > chromosome_multiple.txt

# For unknown
   
awk -v chr='unknown' '$3 == chr|| $4 == chr' snp_position.txt | cut -f 1,3,4 > extracted_chr_unknown.txt

join -t $'\t' -1 1 -2 1 extracted_chr_unknown.txt transposed_maize_genotypes.txt > joined_unknown.txt

(cat <(echo -e "SNP_ID\tChromosome\tPosition\tGenotype") && cat joined_unknown.txt) > chromosome_unknown.txt

# Clean up

rm extracted_chr* joined*

```
Here is my brief description of what this code does

1. SNP ID and SNP data from groups ZMMIL, ZMMLR and ZMMMR is extracted from fang_el_al_genotypes.txt file including the header, which is then transposed.

2. Then creating a for loop in bash file, the snp_position.txt file is extracted based on the chromosome number 1 to 10, along with retaining the columns 1,3 and 4. Then the transposed genotype file and the extracted snp files are joined. The joined file is then sorted  by increasing order of the positions containing missing data encoded by ? and decreasing order of the positions containing missing data encoded by -. This creates 20 files in total, each with the header as SNP_ID in the first column, Chromosme in the second column, Position in the third column and Genotype in the subsequent columns.    

3. For multiple and unknown data, two more separate files are created by extracting and joining the genotype file with the extracted snp file as described above.

### Teosinte Data
Here is my snippet of code used for data processing
```
awk 'NR==1 || /ZMP/' fang_et_al_genotypes.txt | cut -f 4-986 > teosinte_genotypes.txt

awk -f transpose.awk teosinte_genotypes.txt > transposed_teosinte_genotypes.txt

sh data_processing.sh

# Here is the snippet of the slurm file

#!/bin/bash

# Iterate through chromosome

for i in {1..10}; do

awk -v chr="$i" '$3 == chr' snp_position.txt | cut -f 1,3,4 > extracted_chr_${i}.txt

join -t $'\t' -1 1 -2 1 extracted_chr_${i}.txt transposed_teosinte_genotypes.txt > joined_${i}.txt

(echo -e "SNP_ID\tChromosome\tPosition\tGenotype" && sort -k3,3n joined_${i}.txt) > chromosome_increasing${i}.txt

(echo -e "SNP_ID\tChromosome\tPosition\tGenotype" && sort -k3,3nr joined_${i}.txt | sed 's/?/-/g') > chromosome_decreasing${i}.txt

done

# For multiple 

awk -v chr='multiple' '$3 == chr|| $4 == chr' snp_position.txt | cut -f 1,3,4 > extracted_chr_multiple.txt

join -t $'\t' -1 1 -2 1 extracted_chr_multiple.txt transposed_teosinte_genotypes.txt > joined_multiple.txt

(cat <(echo -e "SNP_ID\tChromosome\tPosition\tGenotype") && cat joined_multiple.txt) > chromosome_multiple.txt

# For unknown

awk -v chr='unknown' '$3 == chr|| $4 == chr' snp_position.txt | cut -f 1,3,4 > extracted_chr_unknown.txt

join -t $'\t' -1 1 -2 1 extracted_chr_unknown.txt transposed_teosinte_genotypes.txt > joined_unknown.txt

(cat <(echo -e "SNP_ID\tChromosome\tPosition\tGenotype") && cat joined_unknown.txt) > chromosome_unknown.txt

# Clean up

rm extracted_chr* joined*

```
Here is my brief description of what this code does

1. SNP ID and SNP data from groups ZMPBA, ZMPIL and ZMPJA is extracted from fang_el_al_genotypes.txt file including the header, which is then transposed.

2. Then creating a for loop in bash file, the snp_position.txt file is extracted based on the chromosome number 1 to 10, along with retaining the columns 1,3 and 4. Then the transposed genotype file and the extracted snp files are joined. The joined file is then sorted by increasing order of the positions containing missing data encoded by ? and decreasing order of the positions containing missing data encoded by -. This creates 20 files in total, each with the header as SNP_ID in the first column, Chromosme in the second column, Position in the third column and Genotype in the subsequent columns.

3. For multiple and unknown data, two more separate files are created by extracting and joiniing the genotype file with the extracted snp file as described above.
