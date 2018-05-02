task phenolyzer {

  #perl disease_annotation.pl disease.txt -f -p -ph -logistic -out disease/out

  # File DiseaseFile
  # File PhenolyzerExe
  # String IdSample
  # On ne peut préciser l'outdir général car il duplique le /
  #String OutDir

  command <<<
    cd /softs/phenolyzer/ \
    && perl disease_annotation.pl disease.txt -f -p -ph -logistic -out out/disease/out
  >>>

  output {
    File outPhenolyzer = "/softs/phenolyzer/out/disease/out.predicted_gene_scores"
  }
}
