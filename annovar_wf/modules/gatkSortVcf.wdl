task gatkSortVcf {
  String SrunLow
  String WorkflowType
	String IdSample	
	String OutDir
	File GatkExe
	File UnsortedVcf
	command {
		 ${SrunLow} ${GatkExe} SortVcf \
		-I ${UnsortedVcf} \
		-O "${OutDir}${IdSample}/${WorkflowType}/${IdSample}.sorted.vcf"
	}
	output {
		File sortedVcf = "${OutDir}${IdSample}/${WorkflowType}/${IdSample}.sorted.vcf"
		File sortedVcfIndex = "${OutDir}${IdSample}/${WorkflowType}/${IdSample}.sorted.vcf.idx"
	}
}
