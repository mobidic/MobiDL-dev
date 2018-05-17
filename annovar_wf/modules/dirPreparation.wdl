task dirPreparation {
  String WorkflowType
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
    if [ ! -d "${OutDir}${IdSample}/${WorkflowType}" ]; then \
      mkdir "${OutDir}${IdSample}/${WorkflowType}";
    fi 
    if [ ! -d "${OutDir}${IdSample}/${WorkflowType}/disease" ]; \
    then \
      mkdir "${OutDir}${IdSample}/${WorkflowType}/disease"; \
    fi
    if [ ! -d "${OutDir}${IdSample}/${WorkflowType}/achab_excel" ]; \
    then \
      mkdir "${OutDir}${IdSample}/${WorkflowType}/achab_excel"; \
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
    if [ ! -d "${OutDir}${IdSample}/${WorkflowType}/bcftools" ]; then \
      mkdir "${OutDir}${IdSample}/${WorkflowType}/bcftools"; \
    fi
    cp ${InputVcf} ${OutDir}${IdSample}/${WorkflowType}

  }
  output {
    Boolean isPrepared = true
  }
}
