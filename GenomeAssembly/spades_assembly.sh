#!/usr/bin/env bash
# spades_assembly.sh


spades.py -1 ./Paired/SRR522244_1.R1.paired.fastq  -2 ./Paired/SRR522244_2.paired.fastq    -o Rhodo -t 4  &


