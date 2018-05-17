task dirRemove {
  String WorkflowType
  String IdSample
  String OutDir
  String PhenolyzerExe
  File OutPhenolyzer
  File OutAchab
  File OutAchabNewHope

  command {
    if [ -d "${PhenolyzerExe}/out" ]; then \
      rm -rf "${PhenolyzerExe}/out"; \
    fi
    if [ -d "${PhenolyzerExe}/out/disease" ]; then \
      rm -rf "${PhenolyzerExe}/out/disease"; \
    fi
    if [ -d "${PhenolyzerExe}/disease_files" ]; then \
      rm -rf "${PhenolyzerExe}/disease_files"; \
    fi
    if [ -f "${PhenolyzerExe}/disease.txt" ]; then \
      rm "${PhenolyzerExe}/disease.txt"; \
    fi
    if [ -d "${OutDir}${IdSample}/${WorkflowType}/bcftools" ]; then \
      rm -rf "${OutDir}${IdSample}/${WorkflowType}/bcftools"; \
    fi 
    if [ -f "${OutDir}${IdSample}/${WorkflowType}/${IdSample}.avinput" ]; then \
      rm "${OutDir}${IdSample}/${WorkflowType}/${IdSample}.avinput"; \
    fi 
    if [ -f "${OutDir}${IdSample}/${WorkflowType}/${IdSample}.hg19_multianno.txt" ]; then \
      rm "${OutDir}${IdSample}/${WorkflowType}/${IdSample}.hg19_multianno.txt"; \
    fi 
    if [ -f "${OutDir}${IdSample}/${WorkflowType}/${IdSample}.hg19_multianno.vcf" ]; then \
      rm "${OutDir}${IdSample}/${WorkflowType}/${IdSample}.hg19_multianno.vcf"; \
    fi 
    if [ -f "${OutDir}${IdSample}/${WorkflowType}/${IdSample}.sorted.vcf" ]; then \
      rm "${OutDir}${IdSample}/${WorkflowType}/${IdSample}.sorted.vcf"; \
    fi
    if [ -f "${OutDir}${IdSample}/${IdSample}.sorted.vcf.idx" ]; then \
      rm "${OutDir}${IdSample}/${WorkflowType}/${IdSample}.sorted.vcf.idx"; \
    fi
  }
  output {
    Boolean isRemoved = true
  }
}
