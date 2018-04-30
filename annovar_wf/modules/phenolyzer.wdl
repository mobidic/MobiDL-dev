task phenolyzer {

  #perl disease_annotation.pl disease.txt -f -p -ph -logistic -out disease/out

  File DiseaseFile
  File PhenolyzerExe
  String IdSample
  String OutDir

  command {
    perl ${PhenolyzerExe} \
    ${DiseaseFile} \
    -f -p -ph -logistic \
    -out ${OutDir}${IdSample}/disease/${IdSample}.predicted_gene_scores
  }

  output {
    File outPhenolyzer = "${OutDir}${IdSample}/disease/${IdSample}.predicted_gene_scores"
  }
}
