task mpa {

  #python MPA.py -i name.hg19_multianno.vcf -o name.hg19_multianno_MPA.vcf
  
  File MpaExe
  File OutAnnotation
  String SrunLow
  String WorkflowType
  String IdSample
  String OutDir
  String PythonPath

  command {
    ${SrunLow} ${PythonPath} ${MpaExe} \
    -i ${OutAnnotation} \
    -o ${OutDir}${IdSample}/${WorkflowType}/${IdSample}.hg19_multianno_MPA.vcf
  }

  output {
    File outMpa = "${OutDir}${IdSample}/${WorkflowType}/${IdSample}.hg19_multianno_MPA.vcf"
  }

}
