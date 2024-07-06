#!/usr/bin/env nextflow
nextflow.enable.dsl=2

log.info """
STARTING PIPELINE
=*=*=*=*=*=*=*=*=
Sample list: ${params.input}
BED file: ${params.bedfile}
Sequences in:${params.sequences}
"""

process bam_vcf {
	maxForks 1
	publishDir "${params.output}", mode: 'copy'
	input:
		val (Sample)
	output:
		tuple val (Sample), file ("*.hard-filtered.vcf"), file ("*.bam*")
	script:
	"""
	${params.fastq_bam} ${Sample} ${params.sequences}/${Sample}_*_R1_*.fastq.gz ${params.sequences}/${Sample}_*_R2_*.fastq.gz ${params.reference} ${params.bedfile}
	"""
}

process bam_fusions {
	maxForks 1
	publishDir "${params.output}", mode: 'copy', pattern: '*fusion_candidates.features.csv'
	publishDir "${params.output}", mode: 'copy', pattern: '*fusion_candidates.final'
	publishDir "${params.output}", mode: 'copy', pattern: '*mapping_metrics.csv'
	publishDir "${params.output}", mode: 'copy', pattern: '*quant.genes.sf'
	publishDir "${params.output}", mode: 'copy', pattern: '*quant.sf'

	input:
		val (Sample)
	output:
		tuple val (Sample), file ("*fusion_candidates.features.csv"), file ("*fusion_candidates.final"), file ("*mapping_metrics.csv"), file ("*quant.genes.sf"), file ("*quant.sf") 
	script:
	"""
	${params.fastq_fusions} ${Sample} ${params.sequences}/${Sample}_*_R1_*.fastq.gz ${params.sequences}/${Sample}_*_R2_*.fastq.gz ${params.reference} ${params.annotation}
	"""
}

process bam_umi {
	maxForks 1
	publishDir "${params.output}", mode: 'copy'
	input:
		val (Sample)
	output:
		tuple val (Sample), file ("*.bam*")
	script:
	"""	
	${params.fastq_umi} ${Sample} ${params.sequences}/${Sample}_*_R1_*.fastq.gz ${params.sequences}/${Sample}_*_R2_*.fastq.gz ${params.reference} ${params.bedfile}
	"""
}		
	

workflow DBAMVCF {	
	Channel
		.fromPath(params.input)
		.splitCsv(header:false)
		.flatten()
		.map{ it }
		.set { samples_ch }
	main:
	bam_vcf(samples_ch)
}

workflow DBAMFUSIONS {
	Channel
		.fromPath(params.input)
		.splitCsv(header:false)
		.flatten()
		.map{ it }
		.set { samples_ch }
	main:
	bam_fusions(samples_ch)
}

workflow DBAMUMI {
        Channel
                .fromPath(params.input)
                .splitCsv(header:false)
                .flatten()
                .map{ it }
                .set { samples_ch }
        main:
        bam_umi(samples_ch)
}



workflow.onComplete {
	log.info ( workflow.success ? "\n\nDone! Output in the 'bam' directory \n" : "Oops .. something went wrong" )
}
