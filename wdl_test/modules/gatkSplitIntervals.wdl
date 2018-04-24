task gatkSplitIntervals {
  File GatkExe
  File Fasta
  File RefFai
  File RefDict
  File GatkIntervals
  String OutDir
  String IdSample
  Int Threads
  String SubdivisionMode

  command {
    ${GatkExe} SplitIntervals \
    -R ${Fasta} \
    -L ${GatkIntervals} \
    --scatter-count ${Threads} \
    --subdivision-mode ${SubdivisionMode} \
    -O "${OutDir}${IdSample}/intervals/splitted_intervals/"
  }
  output {
    Array[File] splittedIntervals = glob("${OutDir}${IdSample}/intervals/splitted_intervals/*-scattered.intervals")
  }
}
