task captainAchab {

  ## USAGE : perl achab.pl --vcf <vcf_file> --case <index_sample_name> --dad <father_sample_name> --mum <mother_sample_name> --control <control_sample_name>  --trio <YES|NO> --candidates <file with gene symbol of interest>  --phenolyzerFile <phenolyzer output file suffixed by predicted_gene_scores>   --popFreqThr <allelic frequency threshold from 0 to 1 default=0.01>  --customInfo  <info name (will be added in a new column)> --newHope <NO|YES (output FILTER="PASS" and MPAranking < 8 variants | output only NON PASS or MPA_rank = 8 variants )>

  #CAD180045-CI_CSG180964-pere_CSG180965-mere.xlsx


  #--customInfo ${CustomInfo} \
  #--control ${ControlSample} \


  #Trio = dad/mum/case mais si control, trio ne marche pas

  File AchabExe
  File InterestGene
  #String ControlSample
  String FatherSample
  String CaseSample
  String MotherSample
  File OutMpa
  File OutPhenolyzer
  Float AllelicFrequency
  String CheckTrio
  String CustomInfo
  String IdSample
  String NewHope
  String OutDir
  String PerlPath


  command {
    ${PerlPath} ${AchabExe} \
    --vcf ${OutMpa} \
    --outDir ${OutDir}${IdSample}/achab_excel/ \
    --case ${CaseSample} \
    --dad ${FatherSample} \
    --mum ${MotherSample} \
    --trio ${CheckTrio} \
    --candidates ${InterestGene} \
    --phenolyzerFile ${OutPhenolyzer} \
    --popFreqThr ${AllelicFrequency} \
    --customInfo ${CustomInfo} \
    --newHope ${NewHope}
  }
  output {
    File outAchab = "${OutDir}${IdSample}/achab_excel/${CaseSample}_${FatherSample}_${MotherSample}_.xlsx"
  }
}
