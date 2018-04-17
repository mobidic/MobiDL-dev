task gatkHaploTypeCaller {
	File GATK
	File Fasta
	File inputBAM
	String OutDir
	String IDSample
	command {
		java -jar ${GATK} \
		-T HaplotypeCaller \
		-R ${Fasta} \
		-I ${inputBAM} \
		-o "${OutDir}${IDSample}/${IDSample}.vcf"
	}
	output {
		File rawVCF = "${OutDir}${IDSample}/${IDSample}.vcf"
	}  
}
