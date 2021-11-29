#!/usr/bin/env cwl-runner


class: CommandLineTool
id: step2
label: REGENIE workflow Step 2
cwlVersion: v1.0
doc: Run single-variant tests (Step 2 of REGENIE algorithm).

requirements:
  DockerRequirement:
    dockerPull: "briansha/regenie:v2.2.2_boost"
  InitialWorkDirRequirement:
    listing:
    - $(inputs.loco_files)
    - $(inputs.bed_step2)
    - $(inputs.bim_step2)
    - $(inputs.fam_step2)
  ResourceRequirement:
    tmpdirMin: 2000
    outdirMin: 2000

baseCommand:
- regenie
- --step=2
- --bsize=1000

inputs:
  pred_file:
    type: File
    inputBinding:
      prefix: --pred
    doc: Prediction file list from Step 1 
  loco_files:
    type: File[]
  bed_step2:
    type: File
    inputBinding:
      prefix: --bed
      valueFrom: $(self.nameroot)
    doc: Input genotype file
  bim_step2:
    type: File
    doc: Input variant file
  fam_step2:
    type: File
    doc: Input sample file
  phenoFile:
    type: File
    inputBinding:
      prefix: --phenoFile
    doc: Phenotype file
  phenoColList:
    type: string
    inputBinding:
      prefix: --phenoColList
    doc: Comma-delimited string listing phenotypes to test
  covarFile:
    type: File
    inputBinding:
      prefix: --covarFile
    doc: Covariate file
  covarColList:
    type: string
    inputBinding:
      prefix: --covarColList
    doc: Comma-delimited string listing covariates to include
  file_index:
    type: File
    inputBinding:
      prefix: --out
      valueFrom: $(self.nameroot)
      #separate: false

outputs:
  step2_sumstats:
    type: File[]
    outputBinding:
      glob: "*.regenie"
    doc: Summary statistics
