task captainAchab {

  ## USAGE : perl achab.pl --vcf <vcf_file> --case <index_sample_name> --dad <father_sample_name> --mum <mother_sample_name> --control <control_sample_name>  --trio <YES|NO> --candidates <file with gene symbol of interest>  --phenolyzerFile <phenolyzer output file suffixed by predicted_gene_scores>   --popFreqThr <allelic frequency threshold from 0 to 1 default=0.01>  --customInfo  <info name (will be added in a new column)> --newHope <NO|YES (output FILTER="PASS" and MPAranking < 8 variants | output only NON PASS or MPA_rank = 8 variants )>

  #CAD180045-CI_CSG180964-pere_CSG180965-mere.xlsx

  #--case ${IndexSample} \
  #--dad ${FatherSample} \
  #--mum ${MotherSample} \


  #--candidate ${InterestGene} \b

  File AchabExe
  File InterestGene
  File ControlSample
  File FatherSample
  File IndexSample
  File MotherSample
  File OutMpa
  File OutPhenolyzer
  Float AllelicFrequency
  String CheckTrio
  String CustomInfo
  String NewHope


  command <<<
    perl ${AchabExe} \
    --vcf ${OutMpa} \
    --case ${IndexSample} \
    --dad ${FatherSample} \
    --mum ${MotherSample} \
    --control ${ControlSample} \
    --trio ${CheckTrio} \
    --candidates ${InterestGene} \
    --phonolyzerFile ${OutPhenolyzer} \
    --popFreqThr ${AllelicFrequency} \
    --customInfo ${CustomInfo}
    --newHope ${NewHope}
  >>>

}
