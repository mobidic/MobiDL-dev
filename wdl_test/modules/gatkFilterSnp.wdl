task gatkFilterSnp {
  File GatkExe
  File Fasta
  File RefFai
  File RefDict
  File OutSnp
  String IdSample
  String OutDir
  command {
    ${GatkExe} VariantFiltration \
    -R ${Fasta} \
    -V ${OutSnp} \
    -O "${OutDir}${IdSample}/vcfs/${IdSample}.filtered.snp.vcf"
  }
  output {
    File OutFilteredSnp = "${OutDir}${IdSample}/vcfs/${IdSample}.filtered.snp.vcf"
  }
}
