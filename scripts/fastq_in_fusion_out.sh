#!/usr/bin/bash

Sample=$1
forward_fastq=$2
reverse_fastq=$3
reference=$4  #"/usr/local/illumina/genomes/hg38_alt_aware/DRAGEN/8"
annotation=$5  #"/usr/local/illumina/genomes/hg38_alt_aware/genes.gtf.gz"

dragen --watchdog-max-vmem-threshold 182GB -r ${reference} --output-directory ./ --output-file-prefix ${Sample} -1 ${forward_fastq} -2 ${reverse_fastq} --enable-rna true --RGID AML --RGSM ${Sample} --enable-map-align-output true --enable-sort true --output-format bam --generate-sa-tags true --enable-bam-indexing true --enable-map-align true --enable-duplicate-marking true --dupmark-version hash --dump-map-align-registers true --enable-rna-gene-fusion true --enable-rna-quantification true --rna-quantification-library-type A --annotation-file ${annotation} --rna-quantification-gc-bias true --rna-gf-restrict-genes true --qc-enable-depth-metrics false --force
