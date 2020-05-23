#!/bin/bash
## alignReads.sh 

bwa mem GRCh38.primary_assembly.genome.fa  ./Paired/SRR522244_1.R1.paired.fastq  ./UnPaired/SRR522244_2.paired.fastq > algn_SRR522244.sam 

