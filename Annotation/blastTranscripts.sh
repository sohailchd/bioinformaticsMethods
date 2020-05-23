#!/usr/bin/env bash
# blastTranscripts.sh
blastx -db /blastDB/swissprot -query Trinity.fasta -evalue .00001 \
-outfmt "6 qseqid sacc qlen slen bitscore length nident pident evalue ppos" \
-out transcriptBlast.txt \
-num_threads 4 \
1>blast.log 2>blast.err &
