task gatkSelectVariants {
  File GatkExe
  File Fasta
  File RefFai
  File RefDict
  File OutVcf
  String OutDir
  String IdSample
  String SelectType
  command {
    ${GatkExe} SelectVariants \
    -R ${Fasta} \
    -V ${OutVcf} \
    -selectType ${SelectType} \
    -O "${OutDir}${IdSample}/vcfs/{IdSample}.${SelectType}.vcf"
  }

  output {
    File selectVCF = "${OutDir}${IdSample}/vcfs/{IdSample}.${SelectType}.vcf"
  }

}
