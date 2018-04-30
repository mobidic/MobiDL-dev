#Import section
import "modules/annovarForMpa.wdl" as runAnnovarForMpa
import "modules/mpa.wdl" as runMpa
import "modules/phenolyzer.wdl" as runPhenolyzer
import "modules/captainAchab.wdl" as runCaptainAchab

workflow captainAchabWorkflow {

  #Variable section
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
  File refConvert2Annovar
  String humanDb
  ## From phenolyzer
  File diseaseFile
  ## From captainAchab
  File interestGene
  File controlSample
  File fatherSample
  File indexSample
  File motherSample
  Float allelicFrequency
  String checkTrio
  String customInfo
  String newHope


  #Call section

  call runAnnovarForMpa.annovarForMpa {
    input:
    CustomXref = customXref,
    InputVcf = inputVcf,
    RefConvert2Annovar = refConvert2Annovar,
    TableAnnovarExe = tableAnnovarExe,
    HumanDb = humanDb,
    IdSample = idSample,
    OutDir = outDir
  }

  call runMpa.mpa {
    input:
    MpaExe = mpaExe,
    OutAnnotation = annovarForMpa.outAnnotation,
    IdSample = idSample,
    OutDir = outDir
  }

  call runPhenolyzer.phenolyzer {
    input:
    DiseaseFile = diseaseFile,
    PhenolyzerExe = phenolyzerExe,
    IdSample = idSample,
    OutDir = outDir
  }

  call runCaptainAchab.captainAchab {
    input:
    AchabExe = achabExe,
    InterestGene = interestGene,
    ControlSample = controlSample,
    FatherSample = fatherSample,
    IndexSample = indexSample,
    MotherSample = motherSample,
    OutMpa = mpa.outMpa,
    OutPhenolyzer = phenolyzer.outPhenolyzer,
    AllelicFrequency = allelicFrequency,
    CheckTrio = checkTrio,
    CustomInfo = customInfo,
    NewHope = newHope
  }

}
