import "modules/dirPreparation.wdl" as runDirPreparation
import "modules/bwaSamtools.wdl" as runBwa
import "modules/gatkHaplotypeCaller.wdl" as runGatk
import "modules/sambambaIndex.wdl" as runSamIndex
import "modules/gatkSelectVariants.wdl" as selectVariants
import "modules/gatkFilterSnp.wdl" as runGatkFilterSnp
import "modules/gatkFilterIndel.wdl" as runGatkFilterIndel
import "modules/gatkMergeVcf.wdl" as runGatkMergeVcf
import "modules/bedToGatkIntervalList.wdl" as runBedToGatkIntervalList
import "modules/gatkSplitIntervals.wdl" as runGatkSplitIntervals
import "modules/gatkGatherVcf.wdl" as runGatkGatherVcf


workflow wdltest {
	#Exe
	File gatkExe
	String samtoolsExe
	String sambambaExe
	String bwaExe
	File awkExe
	#Output gestion
	String outDir
	String idSample
	#Fasta
	File fasta
	File fastqR1
	File fastqR2
	File refFai
	File refDict
	#Gatk HC
	String threads
	File refAmb
	File refAnn
	File refBwt
	File refPac
	File refSa
	String swMode
	#Bed2IntervalList
	File intervalBed
	#Gatk Split Interval
	String subdivisionMode

	call runDirPreparation.dirPreparation {
		input:
		OutDir = outDir,
		IdSample = idSample
	}

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
		RefFai = refFai,
		IsPrepared = dirPreparation.isPrepared
	}

	call runSamIndex.sambambaIndex {
		input:
		Threads = threads,
		IdSample = idSample,
		OutDir = outDir,
		SambambaExe = sambambaExe,
		InputBam = bwaSamtools.OutBam
	}

	call runBedToGatkIntervalList.bedToGatkIntervalList {
		input:
		AwkExe = awkExe,
		IntervalBed = intervalBed,
		OutDir = outDir,
		IdSample = idSample,
		IsPrepared = dirPreparation.isPrepared
	}

	call runGatkSplitIntervals.gatkSplitIntervals {
		input:
		GatkExe = gatkExe,
		Fasta = fasta,
		RefFai = refFai,
		RefDict = refDict,
		GatkIntervals = bedToGatkIntervalList.GatkIntervals,
		OutDir = outDir,
		IdSample = idSample,
		Threads = threads,
		SubdivisionMode = subdivisionMode,
		IsPrepared = dirPreparation.isPrepared
	}
	scatter (interval in gatkSplitIntervals.splittedIntervals){
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
			GatkIntervals = interval,
			IsPrepared = dirPreparation.isPrepared
		}
	}
	output {
		Array[File] hcVcf = gatkHaplotypeCaller.HcVcf
	}

	call runGatkGatherVcf.gatkGatherVcf {
		input:
		GatkExe = gatkExe,
		OutDir = outDir,
		IdSample = idSample,
		HcVcf = hcVcf
	}

#Split de Select Variant pour les SNP et les INDELS
	call selectVariants.gatkSelectVariants as selectSnps {
		input:
		GatkExe = gatkExe,
		Fasta = fasta,
		RefFai = refFai,
		RefDict = refDict,
		SelectType = "SNP",
		OutDir = outDir,
		IdSample = idSample,
		OutVcf =  gatkGatherVcf.GatheredHcVcf
	}

	call selectVariants.gatkSelectVariants as selectIndels {
		input:
		GatkExe = gatkExe,
		Fasta = fasta,
		RefFai = refFai,
		RefDict = refDict,
		SelectType = "INDEL",
		OutDir = outDir,
		IdSample = idSample,
		OutVcf =  gatkGatherVcf.GatheredHcVcf
	}

	call runGatkFilterSnp.gatkFilterSnp {
		input:
		GatkExe = gatkExe,
		Fasta = fasta,
		RefFai = refFai,
		RefDict = refDict,
		OutSnp = selectSnps.SelectVcf,
		IdSample = idSample,
		OutDir = outDir
	}

	call runGatkFilterIndel.gatkFilterIndel {
		input:
		GatkExe = gatkExe,
		Fasta = fasta,
		RefFai = refFai,
		RefDict = refDict,
		OutIndel = selectIndels.SelectVcf,
		IdSample = idSample,
		OutDir = outDir
	}

	call runGatkMergeVcf.gatkMergeVcf {
		input:
		GatkExe = gatkExe,
		OutFilteredSnp = gatkFilterSnp.OutFilteredSnp,
		OutFilteredIndel = gatkFilterIndel.OutFilteredIndel,
		OutDir = outDir,
		IdSample = idSample
	}

}
