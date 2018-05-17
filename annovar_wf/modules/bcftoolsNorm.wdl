task bcftoolsNorm {
  String SrunLow
  String WorkflowType
	String IdSample	
	String OutDir
	File BcftoolsExe
	File AlignVcf
	command {
		${SrunLow} ${BcftoolsExe} norm -O v -m - \
		-o ${OutDir}${IdSample}/${WorkflowType}/bcftools/${IdSample}_normalize.vcf ${AlignVcf}
	}
	output {
		File outBcfNorm = "${OutDir}${IdSample}/${WorkflowType}/bcftools/${IdSample}_normalize.vcf"
	}
}
