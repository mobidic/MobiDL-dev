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
    --select-type-to-include ${SelectType} \
    -O "${OutDir}${IdSample}/vcfs/${IdSample}.${SelectType}.vcf"
  }

  output {
    File SelectVcf = "${OutDir}${IdSample}/vcfs/${IdSample}.${SelectType}.vcf"
  }

}
