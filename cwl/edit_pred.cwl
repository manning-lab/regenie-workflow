#!/usr/bin/env cwl-runner


class: CommandLineTool
id: step1_edit
label: REGENIE workflow Step 1b (edit LOCO file paths)
cwlVersion: v1.0

requirements:
  DockerRequirement:
    dockerPull: "briansha/regenie:v2.2.2_boost"
  InitialWorkDirRequirement:
    listing:
    - $(inputs.pred_file)
    - entryname: get_basenames.sh
      entry: |
        awk 'sub("/.*/", "", $2)' $(inputs.pred_file.basename) > ridge_pred_fixed.list

baseCommand: [sh, get_basenames.sh]

inputs:
  pred_file:
    type: File
    doc: Pred file from Step 1

outputs:
  pred_file_fixed:
    type: File
    outputBinding:
      glob: ridge_pred_fixed.list
