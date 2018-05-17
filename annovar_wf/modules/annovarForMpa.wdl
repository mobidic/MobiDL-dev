task annovarForMpa {

  #perl path/to/table_annovar.pl path/to/example.vcf humandb/ -buildver hg19 -out path/to/output/name -remove -protocol refGene,refGene,clinvar_20170905,dbnsfp33a,spidex,dbscsnv11,gnomad_exome,gnomad_genome,intervar_20180118 -operation gx,g,f,f,f,f,f,f,f -nastring . -vcfinput -otherinfo -arg '-splicing 20','-hgvs',,,,,,, -xref example/gene_customfullxref.txt
  File CustomXref
  File InputVcf
  File RefAnnotateVariation
  File RefCodingChange
  File RefConvert2Annovar
  File RefRetrieveSeqFromFasta
  File RefVariantsReduction
  File TableAnnovarExe
  String SrunLow
  String WorkflowType 
  String HumanDb
  String IdSample
  String OutDir
  String PerlPath

  command <<<
    ${SrunLow} ${PerlPath} ${TableAnnovarExe} \
    ${InputVcf} \
    ${HumanDb} \
    -buildver hg19 \
    -out ${OutDir}${IdSample}/${WorkflowType}/${IdSample} \
    -remove \
    -protocol refGene,refGene,clinvar_20170905,dbnsfp33a,spidex,dbscsnv11,gnomad_exome,gnomad_genome,intervar_20180118 -operation gx,g,f,f,f,f,f,f,f -nastring . -vcfinput -otherinfo -arg '-splicing 20','-hgvs',,,,,,, \
    -xref ${CustomXref}
  >>>

  output {
    File outAnnotationVcf = "${OutDir}${IdSample}/${WorkflowType}/${IdSample}.hg19_multianno.vcf"
    File outAnnotationAvinput = "${OutDir}${IdSample}/${IdSample}.avinput"
    File outAnnotationTxt = "${OutDir}${IdSample}/${WorkflowType}/${IdSample}.hg19_multianno.txt"
  }
}
