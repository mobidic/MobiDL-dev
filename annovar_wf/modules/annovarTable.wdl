task annovarTable {

  #perl path/to/table_annovar.pl path/to/example.vcf humandb/ -buildver hg19 -out path/to/output/name -remove -protocol refGene,refGene,clinvar_20170905,dbnsfp33a,spidex,dbscsnv11,gnomad_exome,gnomad_genome,intervar_20180118 -operation gx,g,f,f,f,f,f,f,f -nastring . -vcfinput -otherinfo -arg '-splicing 20','-hgvs',,,,,,, -xref example/gene_customfullxref.txt

  File CustomXref
  File InputVcf
  File TableAnnovar
  String IdSample
  String OutDir

  command {
    perl ${TableAnnovar} \
    ${InputVcf} \
    humandb/ \
    -buildver hg19 \
    -out ${OutDir}${IdSample}/${IdSample} \
    -remove \
    -protocol refGene,refGene,clinvar_20170905,dbnsfp33a,spidex,dbscsnv11,gnomad_exome,gnomad_genome,intervar_20180118 -operation gx,g,f,f,f,f,f,f,f -nastring . -vcfinput -otherinfo -arg '-splicing 20','-hgvs',,,,,,, \
    -xref ${CustomXref}
  }

  output {
    File outAnnotation = "${OutDir}${IdSample}/${IdSample}"
  }
}
