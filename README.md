# Transcriptome-
Transcriptomic Analysis using nfcore-rnafusion and Dragen RNA

## DRAGEN RNA Pipeline - ONBOARD

This has the steps to run DRAGEN RNA pipeline onboard Nextseq 1000 machine.

#### Generating the samplesheet on BaseSpace

1. Log in to your BaseSpace account. Go to `Runs`. Create a `New Run` and go to `Run planning`. Enter the run name for your run. For eg. `RUN_3_ANALYSIS_01072024_TRANSCRIPTOME`.

2. Fill the `Run Description`.
3. Select the instrument: `Nexseq 1000/2000`.
Secondary Analysis: `Local`.
Library tube ID:anything (eg. Run name)

4. Configuration:
Application: `Illumina Dragen RNA - 3.10.12`
Description:
Library Prep-kit: `Illumina Stranded Total RNA`
Index Adapter-kit: `IDT-Ilmn RNA UD Indexes Set A Ligation`

7. Index reads: `2 indexes`.
Read type: `Paired End`
Read length: `Read1(151)`, `Index1(10)`, `Index2(10)`, `Read2(151)`
Override Cycles: They will be set based on the read lenth you entered.

9. Make the Sample sheet by entering `Sample Names` and `Set A kit well position`.
The i7 and i5 indexes will be fetched automatically based on the kit you selected. Double check them.

10. Analysis Setting:
Barcode Mismatch index1: `0`
Barcode Mismatch index2: `0`
Fastq compression format: `gzip`
Reference Genome: `hg38 custom alt aware`
Map/Align output format: `BAM`
Keep fastq files: `Yes`
RNA Annotation file: keep it empty
Enable Differential Expression: `No`
`Save As Planned`

#### Requeuing

1. Now on the Nextseq 1000, log into your account on BaseSpace. Go to the `Planned Runs`. Select your run and download the Samplesheet on the machine.

2. Go to the `Process Management` on the machine. Select your run. Click on Requeue. Select the Samplesheet you just uploaded. Start `Requeue`.
