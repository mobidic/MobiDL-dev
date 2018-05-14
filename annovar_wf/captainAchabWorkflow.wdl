#Import section
import "modules/dirPreparation.wdl" as runDirPreparation
import "modules/dirRemove.wdl" as runDirRemove
import "modules/annovarForMpa.wdl" as runAnnovarForMpa
import "modules/mpa.wdl" as runMpa
import "modules/phenolyzer.wdl" as runPhenolyzer
import "modules/captainAchab.wdl" as runCaptainAchab
import "modules/captainAchabNewHope.wdl" as runCaptainAchabNewHope

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
  ## Global
  String idSample
  String outDir
  ## From annovarForMpa
  File customXref
  File inputVcf
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


  #Call section

  call runDirPreparation.dirPreparation{
    input:
    IsRemoved = dirRemove.isRemoved,
    IdSample = idSample,
    OutDir = outDir,
    PhenolyzerExe = phenolyzerExe
  }

  call runDirRemove.dirRemove{
    input:
    IdSample = idSample,
    OutDir = outDir,
    PhenolyzerExe = phenolyzerExe
  }

  call runAnnovarForMpa.annovarForMpa {
    input:
    IsPrepared = dirPreparation.isPrepared,
    IsRemoved = dirRemove.isRemoved,
    CustomXref = customXref,
    InputVcf = inputVcf,
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
    DiseaseFile = diseaseFile,
    IsPrepared = dirPreparation.isPrepared,
    PhenolyzerExe = phenolyzerExe,
    IdSample = idSample,
    OutDir = outDir,
    PerlPath = perlPath
  }
  if (newHope) {
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
  }

  if (!newHope) {
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
}
