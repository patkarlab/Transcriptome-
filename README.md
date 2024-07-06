# Transcriptome-
Transcriptomic Analysis using nfcore-rnafusion and Dragen RNA

## rnafusion pipeline
Source code for this pipeline is in **run_nextflow_transcriptome.sh** file and it has 2 parts. 
* The first one is **nf-core/rnafusion**. nf-core/rnafusion is a bioinformatics best-practice analysis pipeline for RNA sequencing analysis, with curated list of tools for detecting and visualizing fusion genes. You can read about this here: https://github.com/patkarlab/rnafusion.
* The second one is `transcriptome.nf` file in the Scripts folder. It merges all the output files of the tools that were used in  **nf-core/rnafusion** and makes a new excel file. 
* To execute this, make the samplesheet with sample names and name it for eg. `samp.dat`. Then,
```
./run_nextflow_transcriptome.sh samp.dat script.log
```
It will generate log inside script.log

## DRAGEN RNA Pipeline - ONBOARD

This has the steps to run DRAGEN RNA pipeline onboard Nextseq 1000 machine.

#### Generating the samplesheet on BaseSpace

1. Log in to your BaseSpace account. Go to `Runs`. Create a `New Run` and go to `Run planning`. Enter the run name for your run. For eg. `RUN_3_ANALYSIS_01072024_TRANSCRIPTOME`.

2. Fill the `Run Description`.
* Select the instrument: `Nexseq 1000/2000`.
* Secondary Analysis: `Local`.
* Library tube ID:anything (eg. Run name)

4. Configuration:
* Application: `Illumina Dragen RNA - 3.10.12`
* Description: accordingly
* Library Prep-kit: `Illumina Stranded Total RNA`
* Index Adapter-kit: `IDT-Ilmn RNA UD Indexes Set A Ligation`

5.
* Index reads: `2 indexes`.
* Read type: `Paired End`
* Read length: `Read1(151)`, `Index1(10)`, `Index2(10)`, `Read2(151)`
* Override Cycles: They will be set based on the read lenth you entered.

6. Make the Sample sheet by entering `Sample Names` and `Set A kit well position`.
The i7 and i5 indexes will be fetched automatically based on the kit you selected. Double check them.

7. Analysis Setting:
* Barcode Mismatch index1: `0`
* Barcode Mismatch index2: `0`
* Fastq compression format: `gzip`
* Reference Genome: `hg38 custom alt aware`
* Map/Align output format: `BAM`
* Keep fastq files: `Yes`
* RNA Annotation file: keep it empty
* Enable Differential Expression: `No`
* `Save As Planned`


#### Requeuing

1. Now on the Nextseq 1000, log into your account on BaseSpace. Go to the `Planned Runs`. Select your run and download the Samplesheet on the machine.

2. Go to the `Process Management` on the machine. Select your run. Click on Requeue. Select the Samplesheet you just uploaded. Start `Requeue`.

## DRAGEN RNA Pipeline - ONBOARD (using command line)

* This uses Dragen's command line option to detect fusions.
* `main.nf` has the nextflow process written for the dragen command for calling fusions, which is in `fastq_in_fusion_out.sh`.
* `get_bam` is the wrapper script for executing this process. 
* To execute this
```
./get_bam {fastq_location}
```
The output files will be created inside a new directory which will be inside the fastq location directory.
