#!/usr/bin/env bash 
# indexAll.sh

bamdir='bam/'
bamfiles="*.bam"

for bamfile in $bamdir*$bamfiles
do 
	echo "$bamfile"
	fname=`basename $bamfile`
	samtools index \
	$bamfile
done
