#UNIX Assignment

##Data Inspection

###Attributes of `fang_et_al_genotypes`

```
here is my snippet of code used for data inspection
wc fang_et_al_genotypes.txt
ls -l fang_et_al_genotypes.txt
awk -F "\t" '{print NF; exit}' fang_et_al_genotypes.txt
du -h fang_et_al_genotypes.txt
```

By inspecting this file I learned that:

1. The .txt file contains 2744038 words, 2783 lines, and 11051939 characters.
2. The .txt file contains 986 number of columns.
3. The .txt file size is 6.7M


###Attributes of `snp_position.txt`

```
here is my snippet of code used for data inspection
```

By inspecting this file I learned that:

1. point 1
2. point 2
3. point 3

or

* point 1
* point 2
* point 3

##Data Processing

###Maize Data

```
Here is my snippet of code used for data processing

awk 'NR==1 || /ZMM/' fang_et_al_genotypes.txt | cut -f 4-986 > maize_genotypes.txt

awk -f transpose.awk maize_genotypes.txt > transposed_maize_genotypes.txt

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

```

Here is my brief description of what this code does


###Teosinte Data

```
here is my snippet of code used for data processing
```

Here is my brief description of what this code does
