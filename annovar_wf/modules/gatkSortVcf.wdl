task gatkSortVcf {
	String IdSample	
	String OutDir
	File GatkExe
	File UnsortedVcf
	command {
		 ${GatkExe} SortVcf \
		-I ${UnsortedVcf} \
		-O "${OutDir}${IdSample}/${IdSample}.sorted.vcf"
	}
	output {
		File sortedVcf = "${OutDir}${IdSample}/${IdSample}.sorted.vcf"
		File sortedVcfIndex = "${OutDir}${IdSample}/${IdSample}.sorted.vcf.idx"
	}
}
