task dirPreparation {
  String OutDir
  String IdSample

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
  }
  output {
    Boolean isPrepared = true
  }
}
