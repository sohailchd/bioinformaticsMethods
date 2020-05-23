#!/usr/bin/env bash
outDir='quant/'
samdir='../RNA-Seq/Paired/'
sample='*.R1.fastq'
function align {
    for sam in $samdir*$sample
    do
        base=${sam%.*.fastq}
	echo $base
	fname=${base##*/}
	echo $fname
      salmon quant -l IU is \
         -1 $base.R1.fastq \
         -2 $base.R2.fastq \
         -i AipIndex \
         --validateMappings \
         -o $outDir$fname
    done
}

align 1>align.log 2>align.err
