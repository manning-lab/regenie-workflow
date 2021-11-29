#!/usr/bin/env cwl-runner

class: Workflow
cwlVersion: v1.0
label: REGENIE workflow
doc: |
  REGENIE workflow

requirements:
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}

inputs:
  bgen_step1:
    type: File
    doc: .bgen file for Step 1
  bed_step2:
    type: File[]
    doc: Array of .bed genotype files for Step 2
  bim_step2:
    type: File[]
    doc: .bim variant info file for Step 2
  fam_step2:
    type: File[]
    doc: .fam sample info file for Step 2
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
  sumstats:
    type: File[]
    outputSource: combine_outputs/full_output

steps:
- id: step1
  in:
    bgen_step1: bgen_step1
    phenoFile: phenoFile
    phenoColList: phenoColList
    covarFile: covarFile
    covarColList: covarColList
  run: step1.cwl
  out: [pred_file, loco_files]
#- id: edit_pred
#  in:
#    pred_file: step1/pred_file
#  run: edit_pred.cwl
#  out: [pred_file_fixed]
- id: step2
  scatter: [bed_step2, bim_step2, fam_step2, file_index]
  scatterMethod: dotproduct
  in:
    pred_file: step1/pred_file
    loco_files: step1/loco_files
    bed_step2: bed_step2
    bim_step2: bim_step2
    fam_step2: fam_step2
    phenoFile: phenoFile
    phenoColList: phenoColList
    covarFile: covarFile
    covarColList: covarColList
    file_index: bed_step2
  run: step2.cwl
  out: [step2_sumstats]
- id: flatten_array
  in:
    nested_array: step2/step2_sumstats
  run: flatten_array.cwl
  out: [flattened_array]
- id: combine_outputs
  in:
    output_files: flatten_array/flattened_array
      ## The above expression tool could be avoided by using linkMerge: merge_flattened
      ## But currently this throws a validation error -- see GitHub issue:
      ## https://github.com/common-workflow-language/cwltool/issues/929
      #source: step2/step2_sumstats
      #linkMerge: merge_flattened
    phenoColList: phenoColList
  run: combine_outputs.cwl
  out: [full_output]
