task dirRemove {
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
    if [ -d "${OutDir}${IdSample}/bcftools" ]; then \
      rm -rf "${OutDir}${IdSample}/bcftools"; \
    fi 
    if [ -f "${OutDir}${IdSample}/${IdSample}.avinput" ]; then \
      rm "${OutDir}${IdSample}/${IdSample}.avinput"; \
    fi 
    if [ -f "${OutDir}${IdSample}/${IdSample}.hg19_multianno.txt" ]; then \
      rm "${OutDir}${IdSample}/${IdSample}.hg19_multianno.txt"; \
    fi 
    if [ -f "${OutDir}${IdSample}/${IdSample}.hg19_multianno.vcf" ]; then \
      rm "${OutDir}${IdSample}/${IdSample}.hg19_multianno.vcf"; \
    fi 
    if [ -f "${OutDir}${IdSample}/${IdSample}.sorted.vcf" ]; then \
      rm "${OutDir}${IdSample}/${IdSample}.sorted.vcf"; \
    fi
    if [ -f "${OutDir}${IdSample}/${IdSample}.sorted.vcf.idx" ]; then \
      rm "${OutDir}${IdSample}/${IdSample}.sorted.vcf.idx"; \
    fi
  }
  output {
    Boolean isRemoved = true
  }
}
