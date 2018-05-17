task achabNewHope {

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
  String SrunLow
  String WorkflowType
  String CheckTrio
  String CustomInfo
  String IdSample
  String OutDir
  String PerlPath


  command {
    ${SrunLow} ${PerlPath} ${AchabExe} \
    --vcf ${OutMpa} \
    --outDir ${OutDir}${IdSample}/${WorkflowType}/achab_excel/ \
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
    File outAchabNewHope = "${OutDir}${IdSample}/${WorkflowType}/achab_excel/achab_catch_newHope.xlsx"
  }
}
