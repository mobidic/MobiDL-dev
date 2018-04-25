task gatkHaplotypeCaller {
	File GatkExe
	File Fasta
	File RefFai
	File RefDict
	File InputBam
	File BamIndex
	String OutDir
	String IdSample
	#String SwMode
	File GatkIntervals
	String IntervalName = basename("${GatkIntervals}", ".interval")
	Boolean IsPrepared
	command {
		${GatkExe} HaplotypeCaller \
		-R ${Fasta} \
		-I ${InputBam} \
		-L ${GatkIntervals} \
		-O "${OutDir}${IdSample}/vcfs/${IdSample}.${IntervalName}.vcf"
	}
	output {
		File HcVcf = "${OutDir}${IdSample}/vcfs/${IdSample}.${IntervalName}.vcf"
	}
}
