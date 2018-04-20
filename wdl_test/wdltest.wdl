import "modules/bwaSamtools.wdl" as runBwa
import "modules/gatkHaplotypeCaller.wdl" as runGatk
import "modules/sambambaIndex.wdl" as runSamIndex

workflow wdltest {
	#Variables 
	File fasta
	File fastqR1
	File fastqR2
	String gatkExe
	#File gatkinterval
	File refFai
	File refDict
	String outDir
	String idSample
	String bwaExe
	String samtoolsExe
	String threads
	File refAmb
	File refAnn
	File refBwt
	File refPac
	File refSa
	String swMode
	String sambambaExe
	
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
}
