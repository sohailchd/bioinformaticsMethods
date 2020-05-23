#!/usr/bin/env bash
# alignAll.sh


#Initialize variable to contain the directory of un-trimmed fastq files 
fastqPath="/scratch/AiptasiaMiSeq/fastq/"

#Initialize variable to contain the suffix for the left reads
leftSuffix=".R1.fastq"
rightSuffix=".R2.fastq"

pairedOutPath="Paired/"
unpairedOutPath="Unpaired/"


#Loop through all the left-read fastq files in $fastqPath
for leftInFile in $fastqPath*$leftSuffix
do
    #Remove the path from the filename and assign to pathRemoved
    pathRemoved="${leftInFile/$fastqPath/}"
    #Remove the left-read suffix from $pathRemoved and assign to suffixRemoved
    sampleName="${pathRemoved/$leftSuffix/}"
    nice -n19 java -jar /usr/local/programs/Trimmomatic-0.36/trimmomatic-0.36.jar PE \
    -threads 1 -phred33 \
    $fastqPath$sampleName$leftSuffix \
    $fastqPath$sampleName$rightSuffix \
    $pairedOutPath$sampleName$leftSuffix \
    $unpairedOutPath$sampleName$leftSuffix \
    $pairedOutPath$sampleName$rightSuffix \
    $unpairedOutPath$sampleName$rightSuffix \
    HEADCROP:0 \
    ILLUMINACLIP:/usr/local/programs/Trimmomatic-0.36/adapters/TruSeq3-PE.fa:2:30:10 \
    LEADING:20 TRAILING:20 SLIDINGWINDOW:4:30 MINLEN:36 \
    #1>logs/$sampleName.trim.log 2>logs/$sampleName.trim.err

    ## now align with gsnap
    echo "started with the gsnap.."
    nice -n19 gsnap \
    -A sam \
    -D . \
    -d AiptasiaGmapDb \
    $pairedOutPath$sampleName$leftSuffix \
    $pairedOutPath$sampleName$rightSuffix \
    1> sam/$sampleName.sam  
    

done
