import itertools 
from Bio import SeqIO
from Bio.SeqRecord import SeqRecord
from Bio.Seq import Seq


LEFT_FILE = "data/Aip02.R1.fastq"
RIGHT_FILE = "data/Aip02.R2.fastq"
READ_FORMAT = "fastq"
OUT_FILE = "Interleaved.fasta"
OUT_FORMAT = "fasta"

def read_interleave():
    '''
    '''
    left_reads = []
    right_reads = []
    for rec in SeqIO.parse(LEFT_FILE,READ_FORMAT):
        left_reads.append(rec)
    
    for rec in SeqIO.parse(LEFT_FILE,READ_FORMAT):
        right_reads.append(rec)

    sequences = list()
    for left,right in itertools.izip(left_reads,right_reads):
        sequences.append(left)
        sequences.append(right)
    SeqIO.write(sequences,OUT_FILE,OUT_FORMAT)
        


read_interleave()