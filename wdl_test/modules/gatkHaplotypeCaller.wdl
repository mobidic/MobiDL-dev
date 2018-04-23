task gatkHaplotypeCaller {
	File GatkExe
	File Fasta
	File RefFai
	File RefDict
	File InputBam
	File BamIndex
	String OutDir
	String IdSample
	String SwMode
	command {
		${GatkExe} HaplotypeCaller \
		-R ${Fasta} \
		-I ${InputBam} \
		-O "${OutDir}${IdSample}/vcfs/${IdSample}.vcf"
	}
	output {
		File OutVcf = "${OutDir}${IdSample}/vcfs/${IdSample}.vcf"
	}
}
