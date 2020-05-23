#!/usr/bin/env bash
# getReads.sh

# Retrieve the Rhodobacter spheroides NGS reads.
fastq-dump --split-files SRR6808334 1>getReads.log 2>getReads.error &
