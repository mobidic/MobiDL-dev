task gatkGatherVcf {
  File GatkExe
  String OutDir
  String IdSample
  Array[File] HcVcf

  command {
    ${GatkExe} GatherVcfs \
    -I ${sep=' -I' HcVcf} \
    -O "${OutDir}${IdSample}/vcfs/${IdSample}.vcf"
  }
  output {
    File GatheredHcVcf = "${OutDir}${IdSample}/vcfs/${IdSample}.vcf"
    File GatheredHcVcfIndex = "${OutDir}${IdSample}/vcfs/${IdSample}.vcf.idx"
  }
}
