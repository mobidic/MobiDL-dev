task annovarConvertToAnnovar {

  command {
    ${SRUN_SIMPLE_COMMAND} ${PERL} ${ANNOVAR}convert2annovar.pl -format vcf4 ${SAMPLE_ARG} -includeinfo ${INPUT_PATH}${SAMPLE_FILE} -outfile ${INPUT_PATH}${SAMPLE_FILE}.avinput"
  }

  output {

  }
}
