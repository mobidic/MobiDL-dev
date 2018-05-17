task bcftoolsLeftAlign {
  File BcftoolsExe 
  File FastaGenome
  File SplittedVcf
  String SrunLow 
  String WorkflowType
  String OutDir 
  String IdSample 

  command {
    ${SrunLow} ${BcftoolsExe} norm -f ${FastaGenome} \
    -o ${OutDir}${IdSample}/${WorkflowType}/bcftools/${IdSample}_leftalign.vcf ${SplittedVcf}
  }
  output {
    File outBcfLeftAlign = "${OutDir}${IdSample}/${WorkflowType}/bcftools/${IdSample}_leftalign.vcf"
  }
}
