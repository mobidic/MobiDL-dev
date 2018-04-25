# Semaine (1) du 16/04 au 20/04

**NGS**
Plusieurs étapes :
- Amplification de notre échantillon (Tagmentation) soit par amplicon avec des primers désignés ou par capture.
- Clusturing avec la technique de bridge amplification :
On retrouve 2 types d'oligo différents sur nos flow cells. On répète plusieurs étapes après une liaison : polymérisation puis lavage. Quand le bridge se forme on a une polymérisation et une dénaturation du bridge on réalise une répétition de cette étape pour accélérer le process.
Séquenceur --> BCC --> FastQ
- Sequencing : sequence by synthesis. A partir d'un index on va match des nucléotides fluorescent et réaliser un mapping. On répète le process sur le brin complémentaire polymérisé au préalable.
- Data analysis : réalisation du contig et match avec la séquence de référience.

**File format**
- FastQ (Fasta Quality) --> Read
- SAM/BAM (BAM étant le binairede SAM) --> Output des logiciels d'alignement qui lisent des FastQ. Header + Alignement. La partie alignement nous indique où nos différents reads se sont alignés par rapport à notre génome de référence.
- VCF (Variant Calling Format) --> Permet de déterminer les différentes variation (SNP par exemple) et les annotent dans un fichier.

Séquenceur --> FastQ + Reference --> SAM/BAM --> VCF


[Suivi du premier tuto](https://software.broadinstitute.org/wdl/documentation/article?id=7158) sur Broad Institute.

Prise en main de wdl : mise en place d'une pipeline simple prenant des fastQ avec une séquence Fasta de référence pour donner un fichier BAM.
Problèmes au niveau des nombreuses séquences de référence qui ont été oublié. De plus, il faut penser à bien noter le group name de notre run, sans cela, la mise en place du VCF est impossible.

| Tâche(s)                                                          | Réalisée |
| ----------------------------------------------------------------- | -------- |
| Premier test de pipeline | Oui      |  
| Installation d'un poste linux | Oui      |  
| Mise en place d'une session user | Non      |  
| Signature papier CHU | Oui      |  
| Appronfondissement de wdl  | Oui      |  


# Semaine (2) du 23/04 au 27/04

**A faire :**
- Mise en place session user

**Nouvelles tâches**

|Tâche(s)     | Réalisée      |
| ----------- | ------------- |
| Tuto 2 et 3 | Oui  |
| Scatter & Gather | Oui |
| Cromwell server | En cours |



## Lundi 23/04

Poursuite de wdl en suivant le [Tuto 2 - Split de branche](https://software.broadinstitute.org/wdl/documentation/article?id=7221) suivant.
Création de plusieurs branches dans le workflow afin de pouvoir traiter les indels et les SNP issus d'HaplotyCaller de façon différentes. Cela permet entre autre de pouvoir appliquer des paramètres de traitement bien spécifique à chacun pour affiner les résultats.

*Note perso : il est possible d'écrire des commentaires au sein d'un ligne de commande en utilisant le déliminteur command <<<...>>> au lieu de command {} - A TESTER !*

Il est question ensuite de regrouper nos deux fichiers VCFS produits (INDEL / SNP) en un seul VCF afin de savoir quels variants ont été sélectionné après avoir choisi les bons critères de sélection, au prélable. La démarche suivie à était celle du [Tuto 3 - Branch merge](https://software.broadinstitute.org/wdl/documentation/article?id=7334).

**Le petit workflow mis en place semble fonctionnait correctement.**


## Mardi 24/04

Dernière partie du [Tuto Broad](https://software.broadinstitute.org/wdl/documentation/article?id=7614) sur l'utilisation de scatter.

**Ajout de trois nouveaux modules :** bedToGatkIntervalList, gatkGatherVcf et gatkSplitIntervals afin de pouvoir gérer différents intervales. Le module gatkHaplotypeCaller a été modifié afin qu'il puisse prendre en compte des intervales pour pouvoir l'utiliser en scatter. Le gatkGatherVcf permet de fusionner les différents vcf créés pour chaque intervales.

*Commit : https://github.com/mobidic/MobiDL-dev/commit/e59ad1e2d696d1cbc411d881598210d086f02d3a*

HaplotypeCaller nécessite maintenant l'utilisation du scatter de wdl afin de pouvoir gérer les différents intervales et d'accélérer les traitements des données.

## Mercredi 25/04

Ajout du modules **dirPreparation** qui crée les répertoires output des différents modules afin de ne pas créer de bug au lancement du workflow si jamais un des répertoires d'output n'existe pas. Option de script '-d' utilisée car beaucoup plus simple que le "ls \*/" initialement testé.

*Commit :*
- https://github.com/mobidic/MobiDL-dev/commit/11fd0019afcb5fbc61e62420f698ae26c1ca1d08
- https://github.com/mobidic/MobiDL-dev/commit/90ad5a204e5a27a8fc6237e828d0e93840a5a2cb
- https://github.com/mobidic/MobiDL-dev/commit/866797753d20d82268ec74be3e22247ab5678374

**Cromwell avec Docker (daemon)**
Tentative de lancer Cromwell avec de pouvoir conserver les données déjà utilisées. On obtient toutefois les mêmes résultats que s'il était lancé en local en mode non-persistant, sans daemon.

*Nota bene : il faudrait essayer cette commmande là :

    runtime {
      docker: "broadinstitute/genomes-in-the-cloud:1.1010_with_gatk3.5"
      memory: "14 GB"
      cpu: "16"
      disks: "local-disk 200 HDD"
      preemptible: 3
    }

Elle serait à implémenter à l'intérieur des task pour leur dire où se lancer. Les valeurs sont à pendre à titre indicatif.*

**Méthode qui marche pour le mode persistant : **

La commande précédente n'est pas correcte.
Le mode persistant a été pris en compte en ajoutant au fichier conf :

    call-catching{
      enabled = true
      invalidate-bad-cache-results = true
    }

Et dans le .json :

    "write_to_cache": true,
    "read_from_cache": true

On a donc une persistance de nos données en utilisant la commande suivante (sachant que nous sommes dans le répertoire de notre wdl)

    java -Dconfig.file=/softs/conf/minimonster.conf -jar /softs/cromwell-31.jar run wdltest.wdl -i wdltest_inputs.json
