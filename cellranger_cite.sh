#!/bin/bash

## unfortunately Cell Ranger is very annoying and needs fastq files to be formatted like "${TAG}_S*_L00*_R1_001.fastq.gz" etc
## this can be done with some bash scripting..

## This one uses CSV file so no general FASTQ dir is needed  

TAG=$1 ## sample 

FREF=/nfs/cellgeni/CITE_seq_and_hashing/HTOs-TotalSeq-B.csv
REF=/nfs/cellgeni/cellranger_new/refdata-gex-GRCh38-2020-A

IMAGE=/nfs/cellgeni/singularity/images/cellranger-7_0_1.sif

CPU=16
MEM=110
CHEM="" #sometimes cellranger fails if chemistry isn't specified as it can detect 2 differnt types, see here: https://kb.10xgenomics.com/hc/en-us/articles/4483417512077-How-to-run-Cell-Ranger-for-%5B…%5DEX-library-sequenced-with-150x150-and-26x98-configurations-

singularity exec -B /lustre,/nfs $IMAGE cellranger count \
    --id=$TAG \ 
    --libraries=$TAG.library.csv \ 
    --transcriptome=$REF \
    --feature-ref=$FREF \
    --localcores=$CPU \
    --localmem=$MEM \
    --chemistry=$CHEM
