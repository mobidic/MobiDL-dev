task bcftoolsSplit {
  String SrunLow
  String WorkflowType
  Boolean IsPrepared
  File InputVcf
	File BcftoolsExe
  String IdSample 
  String OutDir
  

	command {
    ${SrunLow} ${BcftoolsExe} norm -m-both \
    -o ${OutDir}${IdSample}/${WorkflowType}/bcftools/${IdSample}_splitted.vcf ${InputVcf} 
	}	
  output {
    File outBcfSplit = "${OutDir}${IdSample}/${WorkflowType}/bcftools/${IdSample}_splitted.vcf"
  }

}

