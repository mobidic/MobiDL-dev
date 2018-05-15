task dirPreparation {
  String IdSample
  String OutDir
  String PhenolyzerExe
  File InputVcf

  command {
    if [ ! -d "${OutDir}" ]; \
    then \
      mkdir "${OutDir}"; \
    fi
    if [ ! -d "${OutDir}${IdSample}" ]; \
    then \
      mkdir "${OutDir}${IdSample}"; \
    fi
    if [ ! -d "${OutDir}${IdSample}/disease" ]; \
    then \
      mkdir "${OutDir}${IdSample}/disease"; \
    fi
    if [ ! -d "${OutDir}${IdSample}/achab_excel" ]; \
    then \
      mkdir "${OutDir}${IdSample}/achab_excel"; \
    fi
    if [ ! -d "${PhenolyzerExe}/out" ]; then \
      mkdir "${PhenolyzerExe}/out"; \
    fi
    if [ ! -d "${PhenolyzerExe}/out/disease" ]; then \
      mkdir "${PhenolyzerExe}/out/disease"; \
    fi
    if [ ! -d "${PhenolyzerExe}/disease_files" ]; then \
      mkdir "${PhenolyzerExe}/disease_files"; \
    fi
    if [ ! -d "${OutDir}${IdSample}/bcftools" ]; then \
      mkdir "${OutDir}${IdSample}/bcftools"; \
    fi
    cp ${InputVcf} ${OutDir}${IdSample}/

  }
  output {
    Boolean isPrepared = true
  }
}
