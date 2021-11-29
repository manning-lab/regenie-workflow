#!/usr/bin/env cwl-runner


class: ExpressionTool
cwlVersion: v1.0
doc: Flatten a nested array of files.

requirements:
  DockerRequirement:
    dockerPull: "briansha/regenie_r_base:4.1.0"
  InlineJavascriptRequirement: {}

inputs:
  nested_array:
    type:
      type: array
      items:
        type: array
        items: File

outputs:
  flattened_array:
    type: File[]

expression: |
  ${
    var flat_arr = [];
    for (var i = 0; i < inputs.nested_array.length; i++) {
      var sub_arr = inputs.nested_array[i]
      for (var j = 0; j < inputs.nested_array[i].length; j++) {
          flat_arr.push(inputs.nested_array[i][j]);
      }
    }
    return {'flattened_array': flat_arr};
  }
