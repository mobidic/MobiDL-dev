task bcftoolsSplit {
  
  Boolean IsPrepared
  File InputVcf
	File BcftoolsExe
  String IdSample 
  String OutDir
  

	command {
    ${BcftoolsExe} norm -m-both \
    -o ${OutDir}${IdSample}/bcftools/${IdSample}_splitted.vcf ${InputVcf} 
	}	
  output {
    File outBcfSplit = "${OutDir}${IdSample}/bcftools/${IdSample}_splitted.vcf"
  }

}

