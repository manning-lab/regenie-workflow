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
    - $(inputs.bgen_step1)
    - $(inputs.phenoFile)
    - $(inputs.covarFile)
    - entryname: step1.sh
      entry: |
        regenie \
        --step 1 \
        --bgen=$(inputs.bgen_step1.basename) \\
        --phenoFile=$(inputs.phenoFile.basename) \\
        --covarFile=$(inputs.covarFile.basename) \\
        --phenoColList=$(inputs.phenoColList) \\
        --covarColList=$(inputs.covarColList) \\
        --bsize=1000 \\
        --out fit_bin_out

        awk 'sub("/.*/", "", $2)' fit_bin_out_pred.list > fit_bin_out_fixed_pred.list
  ResourceRequirement:
    tmpdirMin: 2000
    outdirMin: 2000

inputs:
  bgen_step1:
    type: File
    doc: .bgen file for Step 1
  phenoFile:
    type: File
    doc: Phenotype (outcome) file
  phenoColList:
    type: string
    doc: String with comma-delimited phenotypes to test
  covarFile:
    type: File
    doc: Covariate file
  covarColList:
    type: string
    doc: String with comma-delimited covariates to include

outputs:
  step1_output:
    type: File
    outputBinding:
      glob: fit_bin_out_fixed_pred.list
    doc: "List of LOCO predictions"

baseCommand:
- sh
- step1.sh
arguments: []
