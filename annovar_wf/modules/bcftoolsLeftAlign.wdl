task bcftoolsLeftAlign {
  File BcftoolsExe 
  File FastaGenome
  File SplittedVcf
  String OutDir 
  String IdSample 

  command {
    ${BcftoolsExe} norm -f ${FastaGenome} \
    -o ${OutDir}${IdSample}/bcftools/${IdSample}_leftalign.vcf ${SplittedVcf}
  }
  output {
    File outBcfLeftAlign = "${OutDir}${IdSample}/bcftools/${IdSample}_leftalign.vcf"
  }
}
