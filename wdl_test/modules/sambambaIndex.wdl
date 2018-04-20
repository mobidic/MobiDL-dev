task sambambaIndex {
	Int Threads
	String IdSample
	String OutDir
	String SambambaExe
	File InputBam
	command {
		${SambambaExe} index -t ${Threads} \
		${InputBam} \
		"${OutDir}${IdSample}/${IdSample}.bam.bai"
	}
	output {
		File BamIndex = "${OutDir}${IdSample}/${IdSample}.bam.bai"
	}
}