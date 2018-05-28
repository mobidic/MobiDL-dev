task dirPreparation {
  String WorkflowType
  String SampleID
  String OutDir
  String PhenolyzerExe
  File InputVcf
#if [ ! -d "output/" ]; \
#    then \
#      mkdir "output/"; \
#    fi

  command {
    if [ ! -d "output/${SampleID}" ]; \
    then \
      mkdir "output/${SampleID}"; \
    fi
    if [ ! -d "output/${SampleID}/${WorkflowType}" ]; then \
      mkdir "output/${SampleID}/${WorkflowType}";
    fi 
    if [ ! -d "output/${SampleID}/${WorkflowType}/disease" ]; \
    then \
      mkdir "output/${SampleID}/${WorkflowType}/disease"; \
    fi
    if [ ! -d "output/${SampleID}/${WorkflowType}/achab_excel" ]; \
    then \
      mkdir "output/${SampleID}/${WorkflowType}/achab_excel"; \
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
    if [ ! -d "output/${SampleID}/${WorkflowType}/bcftools" ]; then \
      mkdir "output/${SampleID}/${WorkflowType}/bcftools"; \
    fi
    cp ${InputVcf} output/${SampleID}/${WorkflowType}

  }
  output {
    Boolean isPrepared = true
  }
}
