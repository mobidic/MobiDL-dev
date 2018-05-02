task phenolyzer {

  #perl disease_annotation.pl disease.txt -f -p -ph -logistic -out disease/out

  # File DiseaseFile
  # File PhenolyzerExe
  # String IdSample
  # On ne peut préciser l'outdir général car il duplique le /
  #String OutDir

  command {
    perl /softs/phenolyzer/disease_annotation.pl disease.txt -f -p -ph -logistic -out disease/out
  }

  output {
    File outPhenolyzer = "/home/nsoirat/MobiDL-dev/annovar_wf/output/${IdSample}/disease/${IdSample}.out.predicted_gene_scores"
  }
}
