task bwaSamtools {
	File Fasta
	File FastqR1
	File FastqR2
	Int Threads
	String OutDir
	String IdSample
	String BwaExe
	File RefFai
	String SamtoolsExe
	#Index bwa
	File RefAmb
	File RefAnn
	File RefBwt
	File RefPac
	File RefSa
	Boolean IsPrepared
	command {
		#Thread : nombre d'actions en parallèles donc utilisation de différents coeurs
		${BwaExe} mem -M -t ${Threads} \
		-R "@RG\tID:${IdSample}\tSM:${IdSample}" \
		${Fasta} ${FastqR1} ${FastqR2} | ${SamtoolsExe} sort -@ ${Threads} -l 1 -o "${OutDir}${IdSample}/${IdSample}.bam"
	}
	output {
		File OutBam = "${OutDir}${IdSample}/${IdSample}.bam"
	}
}
