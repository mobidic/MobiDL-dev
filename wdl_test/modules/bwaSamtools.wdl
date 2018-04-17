task bwaSamtools {
	File Fasta
	File FastqR1
	File FastqR2
	String OutDir
	String IDSample
	String BwaExe
	String SamtoolsExe
	command {
		${BwaExe} \ ${Fasta} \ ${FastqR1} \ ${FastqR2} | ${SamtoolsExe} \ -o "${OutDir}${IDSample}/${IDSample}.bam"
	}
	output {
		File outBam = "${OutDir}${IDSample}/${IDSample}.bam"
	}
}


