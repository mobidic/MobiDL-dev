task bedToGatkIntervalList {
  File AwkExe
  File IntervalBed
  String IdSample
  String OutDir
  command <<<
    ${AwkExe} 'BEGIN {OFS=""} {if ($1 !~ /track/) {print $1,":",$2+1,"-",$3}}' \
    ${IntervalBed} \
    > "${OutDir}${IdSample}/intervals/gatkIntervals.list"
  >>>
  output {
    File GatkIntervals = "${OutDir}${IdSample}/intervals/gatkIntervals.list"
  }
}
