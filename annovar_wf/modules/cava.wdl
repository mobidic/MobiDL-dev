task cava {

  File CavaExe
  String Python
  String OutDir
  String IdSample
  String CavaDir
  String InputPath

  command {
    ${SRUN_24_COMMAND} ${Python} ${CavaExe} \
    -c ${CavaDir}config.txt \
    -i ${InputPath}${IdSample} \
    -o "${OutDir}${IdSample}.cava"
  }
  output {
    File outCava = "${OUTPUT_PATH}${SAMPLE_FILE}.cava"
  }
}
