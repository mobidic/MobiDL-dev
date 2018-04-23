import "modules/bwaSamtools.wdl" as runBwa
import "modules/gatkHaplotypeCaller.wdl" as runGatk
import "modules/sambambaIndex.wdl" as runSamIndex
import "modules/gatkSelectVariants" as selectVariants

workflow wdltest {
	#Exe
	File gatkExe
	String samtoolsExe
	String sambambaExe
	String bwaExe
	#Output gestion
	String outDir
	String idSample
	#Fasta
	File fasta
	File fastqR1
	File fastqR2
	File refFai
	File refDict
	#File gatkinterval
	String threads
	File refAmb
	File refAnn
	File refBwt
	File refPac
	File refSa
	String swMode
	#Select Variants
	String selectType


	call runBwa.bwaSamtools {
		input:
		Fasta = fasta,
		FastqR1 = fastqR1,
		FastqR2 = fastqR2,
		OutDir = outDir,
		IdSample = idSample,
		BwaExe = bwaExe,
		SamtoolsExe = samtoolsExe,
		Threads = threads,
		RefAmb = refAmb,
		RefAnn = refAnn,
		RefBwt = refBwt,
		RefPac = refPac,
		RefSa = refSa,
		RefFai = refFai
	}

	call runSamIndex.sambambaIndex {
		input:
		Threads = threads,
		IdSample = idSample,
		OutDir = outDir,
		SambambaExe = sambambaExe,
		InputBam = bwaSamtools.OutBam
	}

	call runGatk.gatkHaplotypeCaller {
		input:
		GatkExe = gatkExe,
		Fasta = fasta,
		RefFai = refFai,
		RefDict = refDict,
		InputBam = bwaSamtools.OutBam,
		BamIndex = sambambaIndex.BamIndex,
		OutDir = outDir,
		IdSample = idSample,
		SwMode = swMode
	}

#Split de Select Variant pour les SNP et les INDELS 
	call selectVariants as selectSnps {
		input:
		GatkExe = gatkExe,
		Fasta = fasta,
		RefFai = refFai,
		RefDict = refDict,
		SelectType = "SNP",
		OutDir = outDir,
		IdSample = idSample,
		OutVcf =  gatkHaplotypeCaller.OutVcf
	}

	call selectVariants as selectIndels {
		input:
		GatkExe = gatkExe,
		Fasta = fasta,
		RefFai = refFai,
		RefDict = refDict,
		SelectType = "INDEL",
		OutDir = outDir,
		IdSample = idSample,
		OutVcf =  gatkHaplotypeCaller.OutVcf
	}
}
