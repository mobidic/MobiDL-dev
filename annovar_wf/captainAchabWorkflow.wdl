#Import section
import "modules/dirPreparation.wdl" as runDirPreparation
import "modules/dirRemove.wdl" as runDirRemove
import "modules/annovarForMpa.wdl" as runAnnovarForMpa
import "modules/mpa.wdl" as runMpa
import "modules/phenolyzer.wdl" as runPhenolyzer
import "modules/captainAchab.wdl" as runCaptainAchab
import "modules/captainAchabNewHope.wdl" as runCaptainAchabNewHope
import "modules/bcftoolsSplit.wdl" as runBcftoolsSplit
import "modules/bcftoolsLeftAlign.wdl" as runBcftoolsLeftAlign
import "modules/bcftoolsNorm.wdl" as runBcftoolsNorm
import "modules/gatkSortVcf.wdl" as runGatkSortVcf

workflow captainAchabWorkflow {

  #Variable section
  ## Language Path
  String perlPath
  String pythonPath
  ## Exe
  File achabExe
  File mpaExe
  File phenolyzerExe
  File tableAnnovarExe
  File bcftoolsExe
  File gatkExe
  ## Global
  String idSample
  String outDir
  Boolean keepFiles
  ## From annovarForMpa
  File customXref
  File refAnnotateVariation
  File refCodingChange
  File refConvert2Annovar
  File refRetrieveSeqFromFasta
  File refVariantsReduction
  String humanDb
  ## From phenolyzer
  File diseaseFile
  ## From captainAchab
  Boolean newHope
  File interestGene
  String fatherSample
  String caseSample
  String motherSample
  Float allelicFrequency
  String checkTrio
  String customInfo
  ## From BcftoolsSplit 
  File inputVcf
  ## From BcftoolsLeftAlign 
  File fastaGenome

  #Call section

  call runBcftoolsSplit.bcftoolsSplit {
    input: 
    IsPrepared = dirPreparation.isPrepared, 
    InputVcf = inputVcf, 
    BcftoolsExe = bcftoolsExe, 
    IdSample = idSample, 
    OutDir = outDir
  }

  call runBcftoolsLeftAlign.bcftoolsLeftAlign {
    input:
    BcftoolsExe = bcftoolsExe, 
    FastaGenome = fastaGenome, 
    SplittedVcf = bcftoolsSplit.outBcfSplit, 
    OutDir = outDir, 
    IdSample = idSample
  }

  call runBcftoolsNorm.bcftoolsNorm {
    input: 
    IdSample = idSample, 
    OutDir = outDir, 
    BcftoolsExe = bcftoolsExe, 
    AlignVcf = bcftoolsLeftAlign.outBcfLeftAlign
  }

  call runGatkSortVcf.gatkSortVcf {
    input:
    IdSample = idSample, 
    OutDir = outDir, 
    GatkExe = gatkExe, 
    UnsortedVcf = bcftoolsNorm.outBcfNorm
  }

  call runDirPreparation.dirPreparation{
    input:
    IdSample = idSample,
    OutDir = outDir,
    PhenolyzerExe = phenolyzerExe,
    InputVcf = inputVcf
  }

  if (!keepFiles) {

    call runDirRemove.dirRemove{
      input:
      IdSample = idSample,
      OutDir = outDir,
      PhenolyzerExe = phenolyzerExe,
      OutPhenolyzer = phenolyzer.outPhenolyzer,
      OutAchab = captainAchab.outAchab, 
      OutAchabNewHope = captainAchabNewHope.outAchab
    }
  }
  
  call runAnnovarForMpa.annovarForMpa {
    input:
    CustomXref = customXref,
    InputVcf = gatkSortVcf.sortedVcf,
    RefAnnotateVariation = refAnnotateVariation,
    RefCodingChange = refCodingChange,
    RefConvert2Annovar = refConvert2Annovar,
    RefRetrieveSeqFromFasta = refRetrieveSeqFromFasta,
    RefVariantsReduction = refVariantsReduction,
    TableAnnovarExe = tableAnnovarExe,
    HumanDb = humanDb,
    IdSample = idSample,
    OutDir = outDir,
    PerlPath = perlPath
  }

  call runMpa.mpa {
    input:
    MpaExe = mpaExe,
    OutAnnotation = annovarForMpa.outAnnotationVcf,
    IdSample = idSample,
    OutDir = outDir,
    PythonPath = pythonPath
  }

  call runPhenolyzer.phenolyzer {
    input:
    IsPrepared = dirPreparation.isPrepared,
    DiseaseFile = diseaseFile,
    PhenolyzerExe = phenolyzerExe,
    IdSample = idSample,
    OutDir = outDir,
    PerlPath = perlPath
  }
  call runCaptainAchabNewHope.captainAchabNewHope {
    input:
     AchabExe = achabExe,
     InterestGene = interestGene,
     FatherSample = fatherSample,
     CaseSample = caseSample,
     MotherSample = motherSample,
     OutMpa = mpa.outMpa,
     OutPhenolyzer = phenolyzer.outPhenolyzer,
     AllelicFrequency = allelicFrequency,
     CheckTrio = checkTrio,
     CustomInfo = customInfo,
     IdSample = idSample,
     OutDir = outDir,
     PerlPath = perlPath
   }

  call runCaptainAchab.captainAchab {
     input:
     AchabExe = achabExe,
     InterestGene = interestGene,
     FatherSample = fatherSample,
     CaseSample = caseSample,
     MotherSample = motherSample,
     OutMpa = mpa.outMpa,
     OutPhenolyzer = phenolyzer.outPhenolyzer,
     AllelicFrequency = allelicFrequency,
     CheckTrio = checkTrio,
     CustomInfo = customInfo,
     IdSample = idSample,
     OutDir = outDir,
     PerlPath = perlPath
  }
}
