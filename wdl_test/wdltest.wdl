import "modules/bwaSamtools.wdl" as runBwa
import "modules/gatkHaploTypeCaller.wdl" as runGatk

workflow wdltest {
	#Variables 
	File fasta
	File fastqr1
	File fastqr2
	File gatk
	File inputbam
	String outdir
	String idsample
	String bwaexe
	String samtoolsexe
	
	call runBwa.bwaSamtools {
		input:
		Fasta=fasta,
		FastqR1=fastqr1,
		FastqR2=fastqr2,
		OutDir=outdir,
		IDSample=idsample,
		BwaExe=bwaexe,
		SamtoolsExe=samtoolsexe,
	}
	call runGatk.gatkHaploTypeCaller {
		input:
		GATK=gatk,
		Fasta=fasta,
		inputBAM=bwaSamtools.outBam,
		OutDir=outdir,
		IDSample=idsample,
	}	
}
