task dirPreparation {
  String OutDir
  String IdSample

  command {
    if [! -d "${OutDir}"]; \
    then \
      mkdir "${OutDir}"; \
    fi
    if [! -d "${OutDir}${IdSample}"]; \
    then \
      mkdir "${OutDir}${IdSample}"; \
    fi
    if [! -d "${OutDir}${IdSample}/vcfs"]; \
    then \
      mkdir "${OutDir}${IdSample}/vcfs"; \
    fi
    if [! -d "${OutDir}${IdSample}/intervals"]; \
    then \
      mkdir "${OutDir}${IdSample}/intervals"; \
    fi
    if [! -d "${OutDir}${IdSample}/intervals/splitted_intervals"]; \
    then \
      mkdir "${OutDir}${IdSample}/intervals/splitted_intervals"; \
    fi
  }
  output {
    Boolean isPrepared = true
  }
}
