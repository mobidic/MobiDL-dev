task gatkMergeVcf {
  File GatkExe
  File OutFilteredSnp
  File OutFilteredIndel
  String OutDir
  String IdSample
  command {
    ${GatkExe} MergeVcfs \
    -I ${OutFilteredSnp} \
    -I ${OutFilteredIndel} \
    -O "${OutDir}${IdSample}/vcfs/${IdSample}.merge.vcf"
  }
  output {
    File OutMergeVcf = "${OutDir}${IdSample}/vcfs/${IdSample}.merge.vcf"
  }
}
