task gatkCollectInsertSizeMetrics {
	#https://software.broadinstitute.org/gatk/documentation/tooldocs/current/picard_analysis_CollectMultipleMetrics.php
	#global variables
	String SrunLow
	String SampleID
	String OutDir
	String WorkflowType
	String GatkExe
	File RefFasta
	#task specific variables
	File BamFile
	command {
		${SrunLow} ${GatkExe} CollectInsertSizeMetrics \
		-I ${BamFile} \
		-H "${OutDir}${SampleID}/${WorkflowType}/PicardQualityDir/${SampleID}_insert_size_metrics.pdf" \
		-O "${OutDir}${SampleID}/${WorkflowType}/PicardQualityDir/${SampleID}_insert_size_metrics.txt" \
		-M 0.5
	}
	output {
		File insertSizeMetricsTxt = "${OutDir}${SampleID}/${WorkflowType}/PicardQualityDir/${SampleID}_insert_size_metrics.txt"
		File insertSizeMetricsPdf = "${OutDir}${SampleID}/${WorkflowType}/PicardQualityDir/${SampleID}_insert_size_metrics.pdf"
	}
}