#!/usr/bin/env python

from Bio import SeqIO
from Bio.SeqRecord import SeqRecord
from Bio.Seq import Seq
import re 
import time


### defaults
DROSOPHILA_GENOME_FILE = "genome/dmel-all-chromosome-r6.fasta"
DEFAULT_FORMAT = "fasta"
KMER_SIZE = 6
OUTFILE_KMER = "unique_kmers.fasta"


def read_sequences(file=DROSOPHILA_GENOME_FILE,format=DEFAULT_FORMAT):
    '''
        Reads the genome file in given format
        params
            file: path to file, default= DROSOPHILA_GENOME_FILE
            format: format of the file, default= FASTA
    '''
    unique_kmers = set()
    try:
        with open(OUTFILE_KMER,"w"):
            for seq_record in SeqIO.parse(file,format):
                if re.match(r"^\d{1,1}\D*$", seq_record.id):
                    for kmer in _sliding_window(seq_record.seq,KMER_SIZE):
                        unique_kmers.add(kmer)

        ## write the unique kmers to file in fasta
        write_unique_seq(unique_kmers)     

    except FileNotFoundError as e:
        print("Please make sure path to the file is correct. \n{0}".format(e))

    except Exception as e:
        print("Error while find kmers : {0}".format(e))




def write_unique_seq(unique_kmers):
        sequences = list()
        counter = 0
        for s in unique_kmers:
            counter += 1
            sequences.append(SeqRecord(Seq(s),id="id_"+str(counter),description="Desc: kmer_"+str(counter)))
        
        SeqIO.write(sequences,OUTFILE_KMER,DEFAULT_FORMAT)
 
        print("unique k-mers writen to file:  {0}".format(OUTFILE_KMER))
        print("Total unique k-mers found: {0}".format(counter))



def _sliding_window(seq,window_size):
    '''
        print the k-mers of size window_size 
        params:
            seq: seq string 
            window_size: size of the k-mer 
        rtype: array of k-mers
    '''
    start = 0
    end   = len(seq) - window_size + 1
    print("length of the chromosome seq : {0}".format(len(seq)))
    for pos in range(start,end):
        yield str(seq[pos:pos+window_size])



if __name__=="__main__":
    start = time.time()
    read_sequences()
    end = time.time()
    print("Total Time for for execution : {0} secs.".format(end-start))

