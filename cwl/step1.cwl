#!/usr/bin/env cwl-runner


class: CommandLineTool
id: step1
label: REGENIE workflow Step 1
cwlVersion: v1.0
doc: Run whole-genome regression (Step 1 of REGENIE algorithm).

requirements:
  DockerRequirement:
    dockerPull: "briansha/regenie:v2.2.2_boost"
  InitialWorkDirRequirement:
    listing:
    - entryname: get_basenames.sh
      entry: |
        awk 'sub("/.*/", "", $2)' ridge_pred.list > ridge_pred_fixed.list
#    listing:
#    - $(inputs.bgen_step1)
#    - $(inputs.phenoFile)
#    - $(inputs.covarFile)
#    - entryname: step1.sh
#      entry: |
#        regenie \
#        --step 1 \
#        --bgen=$(inputs.bgen_step1.basename) \\
#        --phenoFile=$(inputs.phenoFile.basename) \\
#        --covarFile=$(inputs.covarFile.basename) \\
#        --phenoColList=$(inputs.phenoColList) \\
#        --covarColList=$(inputs.covarColList) \\
#        --bsize=1000 \\
#        --out fit_bin_out
#
#        awk 'sub("/.*/", "", $2)' fit_bin_out_pred.list > fit_bin_out_fixed_pred.list
  ResourceRequirement:
    tmpdirMin: 2000
    outdirMin: 2000
  ShellCommandRequirement: {}

baseCommand:
- regenie
- --step=1
- --bsize=1000
- --out=ridge

arguments:
  - valueFrom: "&& bash get_basenames.sh"
    shellQuote: false
    position: 100

inputs:
  bgen_step1:
    type: File
    inputBinding:
      prefix: --bgen
    doc: .bgen file for Step 1
  phenoFile:
    type: File
    inputBinding:
      prefix: --phenoFile
    doc: Phenotype (outcome) file
  phenoColList:
    type: string
    inputBinding:
      prefix: --phenoColList
    doc: String with comma-delimited phenotypes to test
  covarFile:
    type: File
    inputBinding:
      prefix: --covarFile
    doc: Covariate file
  covarColList:
    type: string
    inputBinding:
      prefix: --covarColList
    doc: String with comma-delimited covariates to include

outputs:
  pred_file:
    type: File
    outputBinding:
      glob: ridge_pred_fixed.list
    doc: "File listing LOCO prediction files"
  loco_files:
    type: File[]
    outputBinding:
      glob: "*.loco"
