#!/usr/bin/env bash
# trim.sh

pairedOutPath="Paired/"
unpairedOutPath="Unpaired/"

nice -n19 java -jar /usr/local/programs/Trimmomatic-0.36/trimmomatic-0.36.jar PE \
-threads 1 -phred33 \
SRR522244_1.fastq \
SRR522244_2.fastq \
Paired/SRR522244_1.R1.paired.fastq \
Unpaired/SRR522244_1.unpaired.fastq \
Paired/SRR522244_2.paired.fastq \
Unpaired/SRR522244_2.unpaired.fastq \
HEADCROP:0 \
ILLUMINACLIP:/usr/local/programs/Trimmomatic-0.36/adapters/TruSeq3-PE.fa:2:30:10 \
LEADING:20 TRAILING:20 SLIDINGWINDOW:4:30 MINLEN:36 \
1>SRR522244.trim.log 2>SRR522244.trim.err 
