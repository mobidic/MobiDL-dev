task captainAchabNewHope {

  #Trio = dad/mum/case mais si control, trio ne marche pas

  File AchabExe
  File GenesOfInterest
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
  String OutDir
  String PerlPath


  command {
    ${PerlPath} ${AchabExe} \
    --vcf ${OutMpa} \
    --outDir ${OutDir}${IdSample}/achab_excel/ \
    --case ${CaseSample} \
    --dad ${FatherSample} \
    --mum ${MotherSample} \
    ${CheckTrio} \
    --candidates ${GenesOfInterest} \
    --phenolyzerFile ${OutPhenolyzer} \
    --popFreqThr ${AllelicFrequency} \
    --newHope \
    --customInfo ${CustomInfo} 

  }
  output {
    File outAchab = "${OutDir}${IdSample}/achab_excel/achab_catch_newHope.xlsx"
  }
}
