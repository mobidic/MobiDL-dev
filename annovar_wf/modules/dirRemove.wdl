task dirRemove {
  String IdSample
  String OutDir
  String PhenolyzerExe

  command {
    if [ -d "${OutDir}" ]; \
    then \
      rm -rf "${OutDir}"; \
    fi
    if [ -d "${OutDir}${IdSample}" ]; \
    then \
      rm -rf "${OutDir}${IdSample}"; \
    fi
    if [ -d "${OutDir}${IdSample}/disease" ]; \
    then \
      rm -rf "${OutDir}${IdSample}/disease"; \
    fi
    if [ -d "${OutDir}${IdSample}/achab_excel" ]; \
    then \
      rm -rf "${OutDir}${IdSample}/achab_excel"; \
    fi
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

  }
  output {
    Boolean isRemoved = true
  }
}
