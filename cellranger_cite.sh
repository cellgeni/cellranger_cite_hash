#!/bin/bash

## unfortunately Cell Ranger is very annoying and needs fastq files to be formatted like *_S1_L001_R1_001.fastq.gz etc
## this can be done with some bash scripting..

## This one uses CSV file so no general FASTQ dir is needed  

TAG=$1 ## sample 

FREF=/nfs/cellgeni/CITE_seq_and_hashing/HTOs-TotalSeq-B.csv
REF=/nfs/cellgeni/cellranger_new/refdata-gex-GRCh38-2020-A

## example of library csv: 
#fastqs,sample,library_type
#/lustre/scratch117/cellgen/cellgeni/astupnikov/GSE148837/fastqs/CiteHash/GSM4483704,GSM4483704,Gene Expression
#/lustre/scratch117/cellgen/cellgeni/astupnikov/GSE148837/fastqs/CiteHash/GSM4483705,GSM4483705,Antibody Capture

cellranger count --id=$TAG --libraries=$TAG.library.csv --transcriptome=$REF --feature-ref=$FREF --localcores=16 --localmem=110
