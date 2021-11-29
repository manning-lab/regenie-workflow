#!/usr/bin/env cwl-runner


class: CommandLineTool
id: "Regenie"
label: "Regenie workflow"
cwlVersion: v1.0
doc: Concatenate REGENIE output files into a single file.

requirements:
  DockerRequirement:
    dockerPull: "briansha/regenie_r_base:4.1.0"
  InitialWorkDirRequirement:
    listing:
    - $(inputs.output_files)
    - entryname: concat.sh
      entry: |
        IFS=',' read -r -a pheno_arr <<< $(inputs.phenoColList)
        touch full_output.txt
        for pheno in \${pheno_arr[@]}; do
          file_arr=(\$(ls *_\${pheno}.regenie*))
          head -1 \${file_arr[0]} > \${pheno}_sumstats.txt
          for f in \${file_arr[@]}; do
            tail -n +2 $f >> \${pheno}_sumstats.txt
        done
        done
  ResourceRequirement:
    tmpdirMin: 2000
    outdirMin: 2000
    # Dynamic calculation would require calculation of total file array size?
  InlineJavascriptRequirement: {}

inputs:
  output_files:
    type: File[]
    doc: "Array of Regenie output files (usually per chromosome)"
  phenoColList:
    type: string
    doc: String with comma-delimited phenotypes to test

outputs:
  full_output:
    type: File[]
    outputBinding:
      glob: "*sumstats.txt"
    doc: "A file with all concatenated summary stats."

baseCommand:
- bash
- concat.sh
arguments: []

