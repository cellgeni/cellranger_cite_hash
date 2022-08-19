# Processing CITE-seq and cell hashing datasets with Cell Ranger

[Feature Barcode](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/feature-bc) technology is a method for adding extra layers of information to cells by running single cell gene expression in parallel with other assays.

While we process most of our 10X scRNA-seq experiments with [STARsolo](https://github.com/cellgeni/STARsolo), it's currently impossible to process antibody-based assays. There are three main types of experiments that are used: 1) CITE-seq, which uses antibodies to specific surface proteins to evaluate their abundance on the protein level; 2) cell hashing, which uses relatively non-specific antibodies to label individual samples, in order to "supercharge" a 10X run; 3) CRISPR perturbation analysis. 

The method uses antibodies linked to a particular DNA barcode. Thus, the library structure for feature barcoding is as follows: 
  - R1 contains typical 10X droplet barcode (from one of the whitelists) and UMI; 
  - R2 contains the antibody barcode, which can be located at the beginning of the read, or at some fixed position relative to 5' end of the read. For example, TotalSeq-B barcodes start at 11th nucleotide of read 2. Barcode sequences and locations are specified in the CSV file (see below). 

Used antibodies and the sequence and location of used barcode are usually given in the form of a [feature reference CSV file](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/feature-bc-analysis#feature-ref). There are some examples of CSV files we have used in the past given in this repo in `/csvs`. In general, you have to have the CSV file - but sometimes you can guess it using the 15 bp sequences in the R2 read.

Overall analysis workflow of feature barcoding experiments with `Cell Ranger` can be found [here](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/feature-bc-analysis). Briefly, 
  - we use `cellranger count` command to process gene expression (regular scRNA-seq) and feature barcoding (antibody) experiments simultaneously;
  - library CSV file is used to specify where both fastq files are located. Fastq files need to be formatted according to `Cell Ranger` requirements (i.e. should look like `<sample>_S1_L001_R1_001.fastq.gz`); 
  - feature barcoding CSV file needs to be provided (see above). 

If the experiment is cell hashing, once the counting is complete, one can use [Solo](https://github.com/calico/solo) to demultiplex individual hashed samples. I will add example notebook later, I promise. 
