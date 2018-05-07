#Import section
import "modules/dirPreparation.wdl" as runDirPreparation
import "modules/annovarForMpa.wdl" as runAnnovarForMpa
import "modules/mpa.wdl" as runMpa
import "modules/phenolyzer.wdl" as runPhenolyzer
import "modules/captainAchab.wdl" as runCaptainAchab

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
  File interestGene
  #String controlSample
  String fatherSample
  String caseSample
  String motherSample
  Float allelicFrequency
  String checkTrio
  String customInfo
  String newHope


  #Call section

  call runDirPreparation.dirPreparation{
    input:
    OutDir = outDir,
    IdSample = idSample
  }

  call runAnnovarForMpa.annovarForMpa {
    input:
    IsPrepared = dirPreparation.isPrepared,
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
    IsPrepared = dirPreparation.isPrepared,
    PhenolyzerExe = phenolyzerExe,
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
    NewHope = newHope,
    OutDir = outDir,
    PerlPath = perlPath
  }

}
