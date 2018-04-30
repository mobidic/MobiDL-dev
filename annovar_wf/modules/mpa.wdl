task mpa {

  #python MPA.py -i name.hg19_multianno.vcf -o name.hg19_multianno_MPA.vcf

  File MpaExe
  File OutAnnotation
  String IdSample
  String OutDir 

  command {
    python ${MpaExe} \
    -i ${OutAnnotation} \
    -o ${OutDir}${IdSample}/${IdSample}.hg19_multianno_MPA.vcf
  }

  output {
    File outMpa = "${OutDir}${IdSample}/${IdSample}.hg19_multianno_MPA.vcf"
  }

}
