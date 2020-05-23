#!/usr/bin/env bash 
# alisortAll.sh

samdir='sam/'
samfiles="*.sam"

for samfile in $samdir*$samfiles
do 
	echo "$samfile"
	fname=`basename $samfile`
        echo "$fname"
	samtools sort \
        $samfile\
        -o bam/${fname%.*}.sorted.bam
done
