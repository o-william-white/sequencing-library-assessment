#!/bin/bash

echo "ID,forward,reverse" > config/samples.csv

for i in SRR21814487 SRR21814488 SRR21814489; do 
   echo ${i},data/${i}_1.fastq,data/${i}_2.fastq
done >> config/samples.csv

