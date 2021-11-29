version 1.0

# This workflow is modified from Brian Sharber's initial .wdl script (https://github.com/briansha/Regenie_WDL/blob/master/regenie.wdl) and also borrows key ideas from the FinnGen group's similar workflow (https://github.com/FINNGEN/regenie-pipelines/blob/master/wdl/gwas/regenie.wdl).

workflow Regenie {
    # Refer to Regenie's documentation for the descriptions to most of these parameters.
    input {
        File bgen_step1
        Array[File] bed_step2
        Array[File] bim_step2
        Array[File] fam_step2
        String fit_bin_out_name = "fit_bin_out" # File prefix for the list of predictions produced in Step1.
        File? fit_bin_out
        File? phenoFile
        String? phenoColList
        File? covarFile
        String? covarColList
        String? catCovarList
        File? pred
        #Array[Int] chr_list # List of chromosomes used for analysis.
        #Array[String] phenotype_names # Phenotypes you want to analyze. (Column names).
        String regenie_docker = "briansha/regenie:v2.2.2_boost" # Compiled with Boost IOSTREAM: https://github.com/rgcgithub/regenie/wiki/Using-docker
        String r_base_docker = "briansha/regenie_r_base:4.1.0"  # Ubuntu 18.04, R 4.1.0, and a few Ubuntu and R packages.
    }

    call RegenieStep1WholeGenomeModel {
        input:
            bgen_step1 = bgen_step1,
            fit_bin_out_name = fit_bin_out_name,
            phenoFile = phenoFile,
			phenoColList = phenoColList,
            covarFile = covarFile,
			covarColList = covarColList,
			catCovarList = catCovarList,
            docker = regenie_docker
    }

    scatter (i in range(length(bed_step2))) {
      call RegenieStep2AssociationTesting {
          input:
              bed_step2 = bed_step2[i],
              bim_step2 = bim_step2[i],
              fam_step2 = fam_step2[i],
              phenoFile = phenoFile,
			  phenoColList = phenoColList,
              covarFile = covarFile,
			  covarColList = covarColList,
			  catCovarList = catCovarList,
              pred = RegenieStep1WholeGenomeModel.fit_bin_out,
              docker = regenie_docker,
              output_locos = RegenieStep1WholeGenomeModel.output_locos,
			  file_idx = i
      }
    }

    Array[Array[File]] t_output_files = transpose(RegenieStep2AssociationTesting.test_bin_out_firth)  # Phenotypes w/in chromosomes -> chromosomes w/in phenotypes

    scatter (pheno_results in t_output_files) {
        call join_output {
            input:
                output_files = pheno_results,
                docker = r_base_docker
        }
    }

    output {
		Array[File] summary_stats = join_output.pheno_specific_summary_stats
    }

    meta {
    	author : "Brian Sharber"
        email : "brian.sharber@vumc.org"
        description : "This workflow runs Regenie - see the README on the github for more information - https://github.com/briansha/Regenie_WDL."
    }
}


# In Step 1, the whole genome regression model is fit to the traits
# and a set of genomic predictions are produced as output.
task RegenieStep1WholeGenomeModel {
    # Refer to Regenie's documentation for the descriptions to most of these parameters.
    input {
        String docker
        String fit_bin_out_name # File prefix for the list of predictions produced.
        File bgen_step1
		File? sample
        Int bsize = 1000  # 1000 is recommended by regenie's documentation
        Float memory = 3.5
        Int? disk_size_override
        Int cpu = 1
        Int preemptible = 1
        Int maxRetries = 0

        File? phenoFile
        String? phenoColList
        File? covarFile
        String? covarColList
        String? catCovarList
        File? pred
    }
    Float genotype_size = size(bgen_step1, "GiB")
    Int disk = select_first([disk_size_override, ceil(10.0 + 2.0 * genotype_size)])

    command <<<
        set -euo pipefail
        regenie \
        --step 1 \
        --bgen=~{bgen_step1} \
        --phenoFile=~{phenoFile} \
        ~{if defined(covarFile) then "--covarFile=~{covarFile} " else " "} \
        ~{if defined(sample) then "--sample=~{sample} " else " "} \
        ~{if defined(phenoColList) then "--phenoColList=~{phenoColList} " else " "} \
        ~{if defined(covarColList) then "--covarColList=~{covarColList} " else " "} \
        ~{if defined(catCovarList) then "--catCovarList=~{catCovarList} " else " "} \
        ~{if defined(pred) then "--pred=~{pred} " else " "} \
        --bsize=~{bsize} \
        --out fit_bin_out

        # Need to remove absolute filepaths from _pred.list
        # Replace absolute filepaths in _pred.list with basenames only
        awk 'sub("/.*/", "", $2)' fit_bin_out_pred.list > fit_bin_out_fixed_pred.list 
    >>>

    output {
        File fit_bin_out = "fit_bin_out_fixed_pred.list" # Refers to the list of loco files written. Lists the files as being located in the current working directory.
        Array[File] output_locos = glob("*.loco") # Writes n loco files for n phenotypes.
    }

    runtime {
        docker: docker
        memory: memory + " GiB"
	disks: "local-disk " + disk + " HDD"
        cpu: cpu
        preemptible: preemptible
        maxRetries: maxRetries
    }
}

# In Step 2, a set of imputed SNPs are tested for association using a Firth logistic regression model.
task RegenieStep2AssociationTesting {
    # Refer to Regenie's documentation for the descriptions to most of these parameters.
    input {
        String docker
        File bed_step2
        File bim_step2
        File fam_step2
        Array[File] output_locos
        File? fit_bin_out
        Float memory = 3.5
        Int? disk_size_override
        Int cpu = 1
        Int preemptible = 1
        Int maxRetries = 0

        Int bsize = 1000  # 1000 is recommended by regenie's documentation
        File? pred # File containing predictions from Step 1
        String? chr_name
        File? sample
        File? phenoFile
        String? phenoCol
        String? phenoColList
        File? covarFile
        String? covarCol
        String? covarColList
        String? catCovarList
        Int file_idx
    }
    Float dosage_size = size(bed_step2, "GiB")
    Int disk = select_first([disk_size_override, ceil(10.0 + 2.0 * dosage_size)])

    # Loco files are moved to the current working directory due to the list of predictions (pred) expecting them to be there.
    command <<<
        set -euo pipefail
        for file in ~{sep=' ' output_locos}; do \
          mv $file .; \
        done
        regenie \
        --step 2 \
        --bed=~{sub(bed_step2,'\\.bed$','')} \
        --phenoFile=~{phenoFile} \
        ~{if defined(covarFile) then "--covarFile=~{covarFile} " else " "} \
        ~{if defined(sample) then "--sample=~{sample} " else " "} \
        ~{if defined(phenoColList) then "--phenoColList=~{phenoColList} " else " "} \
        ~{if defined(covarColList) then "--covarColList=~{covarColList} " else " "} \
        ~{if defined(catCovarList) then "--catCovarList=~{catCovarList} " else " "} \
        ~{if defined(pred) then "--pred=~{pred} " else " "} \
        --bsize=~{bsize} \
        --out file~{file_idx}
    >>>

    output {
        Array[File] test_bin_out_firth = glob("*.regenie")
    }

    runtime {
        docker: docker
        memory: memory + " GiB"
	disks: "local-disk " + disk + " HDD"
        cpu: cpu
        preemptible: preemptible
        maxRetries: maxRetries
    }
}

# Join together all output relating to the scattered tasks in Step 2.
# For each phenotype, one file will be made containing all analysis from Step 1 on each chromosome used in testing.
task join_output {
  input {
    Array[File] output_files
    String docker
    Float memory = 3.5
    Int? disk_size_override
    Int cpu = 1
    Int preemptible = 1
    Int maxRetries = 0
  }

  #Array[File] all_output_files = flatten(output_files)
  Float files_size = size(output_files, "GiB")
  Int disk = select_first([disk_size_override, ceil(30.0 + 2.0 * files_size)])
  #Array[Array[File]] t_output_files = transpose(output_files)  # Now, chromosomes nested within phenotypes

  command <<<
      head -1 ~{output_files[0]} > output_full.txt
      for output_chunk in ~{sep=" " output_files}; do
          tail -n +2 $output_chunk >> output_full.txt
      done
  >>>

  output {
    File pheno_specific_summary_stats = "output_full.txt"
  }

  runtime {
        docker: docker
        memory: memory + " GiB"
	disks: "local-disk " + disk + " HDD"
        cpu: cpu
        preemptible: preemptible
        maxRetries: maxRetries
  }
}
