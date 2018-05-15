task bcftoolsNorm {
	String IdSample	
	String OutDir
	File BcftoolsExe
	File AlignVcf
	command {
		${BcftoolsExe} norm -O v -m - \
		-o ${OutDir}${IdSample}/bcftools/${IdSample}_normalize.vcf ${AlignVcf}
	}
	output {
		File outBcfNorm = "${OutDir}${IdSample}/bcftools/${IdSample}_normalize.vcf"
	}
}
