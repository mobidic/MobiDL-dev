task gatkFilterIndel {
  File GatkExe
  File Fasta
  File RefFai
  File RefDict
  File OutIndel
  String IdSample
  String OutDir
  command {
    ${GatkExe} VariantFiltration \
    -R ${Fasta} \
    -V ${OutIndel} \
    -O "${OutDir}${IdSample}/vcfs/${IdSample}.filtered.indel.vcf"
  }
  output {
    File OutFilteredIndel = "${OutDir}${IdSample}/vcfs/${IdSample}.filtered.indel.vcf"
  }
}
