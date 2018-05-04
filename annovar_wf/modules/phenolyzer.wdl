task phenolyzer {

  #perl disease_annotation.pl disease.txt -f -p -ph -logistic -out disease/out

  # Phenolyzer a été conçu de sorte à ce que tout le traitement se fasse dans son répertoire, on ne peut pas passer par les liens de Cromwell.
  # On réaliser donc la commande cd pour travailler dans le répertoire de Phenolyzer et on utilise mv pour transférer tous les outputs vers notre dossier output désiré.

  File PhenolyzerExe
  String IdSample
  String OutDir

  command <<<
    cd ${PhenolyzerExe}
    perl disease_annotation.pl disease.txt -f -p -ph -logistic -out out/disease/out
    mv ${PhenolyzerExe}/out/disease/out.predicted_gene_socres

  >>>

  output {
    File outPhenolyzer = "${OutDir}${IdSample}/disease/out.predicted_gene_scores"
  }
}
