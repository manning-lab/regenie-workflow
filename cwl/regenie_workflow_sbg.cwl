{
  "class": "CommandLineTool",
  "cwlVersion": "v1.1",
  "$namespaces": {
    "sbg": "https://sevenbridges.com"
  },
  "baseCommand": [
    "/opt/regenie_v2.0.1.gz_x86_64_Linux"
  ],
  "inputs": [
    {
      "sbg:category": "Main Options",
      "id": "step",
      "type": {
        "type": "enum",
        "symbols": [
          "1",
          "2"
        ],
        "name": "step"
      },
      "inputBinding": {
        "prefix": "--step",
        "shellQuote": false,
        "position": 1
      },
      "label": "Step",
      "doc": "Specify the step: fitting null model (1) or association testing (2)."
    },
    {
      "sbg:category": "Main Options",
      "id": "in_bed",
      "type": "File[]?",
      "label": "Plink files",
      "doc": "Plink files (BED, BIM and FAM). The files should have the same base name (prefix).",
      "sbg:fileTypes": "BED, BIM, FAM"
    },
    {
      "sbg:category": "Main Options",
      "id": "in_pgen",
      "type": "File[]?",
      "inputBinding": {
        "shellQuote": false,
        "position": 3,
        "valueFrom": "${\n    if (inputs.in_pgen)\n    {\n        return '--pgen '.concat(inputs.in_pgen[0].nameroot)\n    }\n    else\n    {\n        return ''\n    }\n}"
      },
      "label": "Plink2 files",
      "doc": "Plink2 files (PGEN, PVAR, PSAM). The files should share the same base name (prefix).",
      "sbg:fileTypes": "PGEN, PVAR, PSAM"
    },
    {
      "sbg:category": "Main Options",
      "id": "in_bgen",
      "type": "File?",
      "inputBinding": {
        "prefix": "--bgen",
        "shellQuote": false,
        "position": 3
      },
      "label": "BGEN file",
      "doc": "BGEN file.",
      "sbg:fileTypes": "BGEN",
      "secondaryFiles": [
        {
          "pattern": ".bgi",
          "required": false
        }
      ]
    },
    {
      "sbg:category": "Main Options",
      "id": "in_bgen_sample",
      "type": "File?",
      "inputBinding": {
        "prefix": "--sample",
        "shellQuote": false,
        "position": 4
      },
      "label": "BGEN sample file",
      "doc": "BGEN sample file.",
      "sbg:fileTypes": "TXT, SAMPLE"
    },
    {
      "sbg:category": "Main Options",
      "id": "keep",
      "type": "File?",
      "inputBinding": {
        "prefix": "--keep",
        "shellQuote": false,
        "position": 6
      },
      "label": "File with samples to keep",
      "doc": "File listing samples to retain in the analysis (no header; starts with FID IID).",
      "sbg:fileTypes": "TXT, TSV"
    },
    {
      "sbg:category": "Main Options",
      "id": "remove",
      "type": "File?",
      "inputBinding": {
        "prefix": "--remove",
        "shellQuote": false,
        "position": 7
      },
      "label": "File with samples to remove",
      "doc": "File listing samples to remove from the analysis (no header; starts with FID IID).",
      "sbg:fileTypes": "TXT, TSV"
    },
    {
      "sbg:category": "Main Options",
      "id": "extract",
      "type": "File?",
      "inputBinding": {
        "prefix": "--extract",
        "shellQuote": false,
        "position": 8
      },
      "label": "File with variant IDs to retain",
      "doc": "File with IDs of variants to retain in the analysis.",
      "sbg:fileTypes": "TXT, TSV"
    },
    {
      "sbg:category": "Main Options",
      "id": "exclude",
      "type": "File?",
      "inputBinding": {
        "prefix": "--exclude",
        "shellQuote": false,
        "position": 9
      },
      "label": "File with variant IDs to remove",
      "doc": "File with IDs of variants to remove from the analysis.",
      "sbg:fileTypes": "TXT, TSV"
    },
    {
      "sbg:altPrefix": "-p",
      "sbg:category": "Main Options",
      "id": "pheno_file",
      "type": "File",
      "inputBinding": {
        "prefix": "--phenoFile",
        "shellQuote": false,
        "position": 10
      },
      "label": "Phenotype file",
      "doc": "Phenotype file (header required starting with FID IID).",
      "sbg:fileTypes": "TXT, TSV"
    },
    {
      "sbg:category": "Main Options",
      "id": "pheno_col",
      "type": "string?",
      "inputBinding": {
        "prefix": "--phenoCol",
        "shellQuote": false,
        "position": 11
      },
      "label": "Phenotype column",
      "doc": "Phenotype name in header (use for each phenotype to keep). Can use parameter expansion {i:j}."
    },
    {
      "sbg:category": "Main Options",
      "id": "pheno_col_list",
      "type": "string[]?",
      "inputBinding": {
        "prefix": "--phenoColList",
        "itemSeparator": ",",
        "shellQuote": false,
        "position": 12
      },
      "label": "Phenotype columns to keep",
      "doc": "Comma separated list of phenotype names to keep. Can use parameter expansion {i:j}."
    },
    {
      "sbg:altPrefix": "-c",
      "sbg:category": "Main Options",
      "id": "covar_file",
      "type": "File?",
      "inputBinding": {
        "prefix": "--covarFile",
        "shellQuote": false,
        "position": 13
      },
      "label": "Covariate file",
      "doc": "Covariate file (header required starting with FID IID).",
      "sbg:fileTypes": "TXT, TSV"
    },
    {
      "sbg:category": "Main Options",
      "id": "covar_col",
      "type": [
        "null",
        {
          "type": "array",
          "items": "string",
          "inputBinding": {
            "separate": true,
            "prefix": "--covarCol"
          }
        }
      ],
      "inputBinding": {
        "shellQuote": false,
        "position": 14
      },
      "label": "Covariate columns",
      "doc": "Covariate name in header (use for each covariate to keep). Can use parameter expansion {i:j}."
    },
    {
      "sbg:category": "Main Options",
      "id": "covar_col_list",
      "type": "string[]?",
      "inputBinding": {
        "prefix": "--covarColList",
        "itemSeparator": ",",
        "shellQuote": false,
        "position": 15
      },
      "label": "Covariates to keep",
      "doc": "Covariate names to keep. Can use parameter expansion {i:j}"
    },
    {
      "sbg:category": "Main Options",
      "sbg:toolDefaultValue": "False",
      "id": "bt",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--bt",
        "shellQuote": false,
        "position": 16
      },
      "label": "Analyze phenotypes as binary",
      "doc": "Analyze phenotypes as binary."
    },
    {
      "sbg:category": "Main Options",
      "sbg:altPrefix": "-1",
      "id": "cc12",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--cc12",
        "shellQuote": false,
        "position": 17
      },
      "label": "Use control 1 case 2 encoding for binary traits",
      "doc": "Use control=1, case=2, missing=NA encoding for binary traits."
    },
    {
      "sbg:category": "Main Options",
      "sbg:altPrefix": "-b",
      "id": "bsize",
      "type": "int",
      "inputBinding": {
        "prefix": "--bsize",
        "shellQuote": false,
        "position": 18
      },
      "label": "Size of genotype blocks",
      "doc": "Size of genotype blocks."
    },
    {
      "sbg:category": "Main Options",
      "sbg:toolDefaultValue": "5",
      "id": "cv",
      "type": "int?",
      "inputBinding": {
        "prefix": "--cv",
        "shellQuote": false,
        "position": 20
      },
      "label": "Number of cross validation folds",
      "doc": "Number of cross validation (CV) folds. Default: 5."
    },
    {
      "sbg:category": "Main Options",
      "id": "loocv",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--loocv",
        "shellQuote": false,
        "position": 21
      },
      "label": "Use leave-one out cross validation",
      "doc": "Use leave-one out cross validation (LOOCV)."
    },
    {
      "sbg:category": "Main Options",
      "sbg:toolDefaultValue": "5",
      "id": "l0",
      "type": "int?",
      "inputBinding": {
        "prefix": "--l0",
        "shellQuote": false,
        "position": 22
      },
      "label": "Number of ridge parameters [l0]",
      "doc": "Number of ridge parameters to use when fitting models within blocks [evenly spaced in (0,1)]. Default: 5."
    },
    {
      "sbg:category": "Main Options",
      "sbg:toolDefaultValue": "5",
      "id": "l1",
      "type": "int?",
      "inputBinding": {
        "prefix": "--l1",
        "shellQuote": false,
        "position": 23
      },
      "label": "Number of ridge parameters to use [l1]",
      "doc": "Number of ridge parameters to use when fitting model across blocks [evenly spaced in (0,1)]. Default: 5."
    },
    {
      "sbg:category": "Main Options",
      "sbg:toolDefaultValue": "False",
      "id": "low_mem",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--lowmem",
        "shellQuote": false,
        "position": 24
      },
      "label": "Reduce memory usage with temporary files",
      "doc": "Reduce memory usage by writing level 0 predictions to temporary files."
    },
    {
      "sbg:toolDefaultValue": "Matches --out prefix",
      "sbg:category": "Main Options",
      "id": "low_mem_prefix",
      "type": "string?",
      "inputBinding": {
        "prefix": "--lowmem-prefix",
        "shellQuote": false,
        "position": 24
      },
      "label": "Prefix for step 1 temporary files",
      "doc": "Prefix for step 1 temporary files. Default: Matches --out."
    },
    {
      "sbg:category": "Main Options",
      "id": "strict",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--strict",
        "shellQuote": false,
        "position": 25
      },
      "label": "Remove all samples with missingness",
      "doc": "Remove all samples with missingness at any of the traits."
    },
    {
      "sbg:category": "Main Options",
      "id": "prefix",
      "type": "string?",
      "label": "Prefix for output files",
      "doc": "Prefix for output files."
    },
    {
      "sbg:category": "Main Options",
      "id": "threads",
      "type": "int?",
      "inputBinding": {
        "prefix": "--threads",
        "shellQuote": false,
        "position": 26
      },
      "label": "Number of threads",
      "doc": "Number of threads."
    },
    {
      "sbg:category": "Platform Options",
      "sbg:toolDefaultValue": "1",
      "id": "cpu_per_job",
      "type": "int?",
      "label": "Number of CPUs per job",
      "doc": "Number of CPUs per job."
    },
    {
      "sbg:category": "Platform Options",
      "sbg:toolDefaultValue": "1000",
      "id": "mem_per_job",
      "type": "int?",
      "label": "Memory per job [MB]",
      "doc": "Memory per job [MB]."
    },
    {
      "sbg:category": "Main Options",
      "id": "pred_files",
      "type": "File[]?",
      "label": "Prediction files from step 1",
      "doc": "Prediction files from step 1."
    },
    {
      "sbg:category": "Main Options",
      "sbg:toolDefaultValue": "False",
      "id": "ignore_pred",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--ignore-pred",
        "shellQuote": false,
        "position": 28
      },
      "label": "Skip reading step 1 predictions",
      "doc": "Skip reading step 1 predictions (equivalent to linear/logistic regression with only covariates)."
    },
    {
      "sbg:category": "Main Options",
      "sbg:toolDefaultValue": "False",
      "id": "write_samples",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--write-samples",
        "shellQuote": false,
        "position": 30
      },
      "label": "Write sample IDs for each trait [step 2]",
      "doc": "Write IDs of samples included for each trait (only in step 2)."
    },
    {
      "sbg:category": "Main Options",
      "sbg:toolDefaultValue": "5",
      "id": "min_mac",
      "type": "int?",
      "inputBinding": {
        "prefix": "--minMAC",
        "shellQuote": false,
        "position": 31
      },
      "label": "Minimum minor allele count",
      "doc": "Minimum minor allele count (MAC) for tested variants. Default: 5."
    },
    {
      "sbg:category": "Main Options",
      "sbg:toolDefaultValue": "False",
      "id": "split",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--split",
        "shellQuote": false,
        "position": 32
      },
      "label": "Split asssociation results into separate files",
      "doc": "Split asssociation results into separate files for each trait."
    },
    {
      "sbg:category": "Main Options",
      "id": "firth",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--firth",
        "shellQuote": false,
        "position": 33
      },
      "label": "Use Firth correction for p-values below cutoff",
      "doc": "Use Firth correction for p-values less than threshold."
    },
    {
      "sbg:category": "Main Options",
      "sbg:toolDefaultValue": "False",
      "id": "approx",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--approx",
        "shellQuote": false,
        "position": 34
      },
      "label": "Use approximation to Firth correction",
      "doc": "Use approximation to Firth correction for computational speedup."
    },
    {
      "sbg:category": "Main Options",
      "id": "spa",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--spa",
        "shellQuote": false,
        "position": 35
      },
      "label": "Use SPA for p-values below the cutoff",
      "doc": "Use saddle point approximation (SPA) for p-values less than threshold."
    },
    {
      "sbg:category": "Main Options",
      "sbg:toolDefaultValue": "0.05",
      "id": "p_thresh",
      "type": "float?",
      "inputBinding": {
        "prefix": "--pThresh",
        "shellQuote": false,
        "position": 36
      },
      "label": "P-value threshold for Firth/SPA correction",
      "doc": "P-value threshold below which to apply Firth/SPA correction. Default: 0.05."
    },
    {
      "sbg:category": "Main Options",
      "id": "chr",
      "type": [
        "null",
        {
          "type": "array",
          "items": "string",
          "inputBinding": {
            "separate": true,
            "prefix": "--chr"
          }
        }
      ],
      "inputBinding": {
        "shellQuote": false,
        "position": 37
      },
      "label": "Chromosomes to test in step 2",
      "doc": "Chromosomes to test in step 2."
    },
    {
      "sbg:category": "Main Options",
      "id": "chr_list",
      "type": "string[]?",
      "inputBinding": {
        "prefix": "--chrList",
        "itemSeparator": ",",
        "shellQuote": false,
        "position": 38
      },
      "label": "List of chromosomes to test in step 2",
      "doc": "List of chromosomes to test in step 2."
    },
    {
      "sbg:category": "Main Options",
      "sbg:toolDefaultValue": "additive",
      "id": "test",
      "type": [
        "null",
        {
          "type": "enum",
          "symbols": [
            "dominant",
            "recessive"
          ],
          "name": "test"
        }
      ],
      "inputBinding": {
        "prefix": "--test",
        "shellQuote": false,
        "position": 39
      },
      "label": "Test",
      "doc": "Type of test. Default: additive test."
    },
    {
      "sbg:category": "Main Options",
      "sbg:toolDefaultValue": "False",
      "id": "gz",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--gz",
        "shellQuote": false,
        "position": 40
      },
      "label": "Compress output files",
      "doc": "Compress output files (gzip format)."
    },
    {
      "sbg:category": "Main Options",
      "id": "pred_files_list",
      "type": "File?",
      "inputBinding": {
        "prefix": "--pred",
        "shellQuote": false,
        "position": 50
      },
      "label": "File with step1 prediction files",
      "doc": "File with step1 prediction files."
    },
    {
      "sbg:category": "Config Options",
      "sbg:toolDefaultValue": "False",
      "id": "ref_first",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--ref-first",
        "shellQuote": false,
        "position": 51
      },
      "label": "Reference allele is the first allele",
      "doc": "Use the first allele as the reference for BGEN or PLINK bed/bim/fam input format. By default reference is assumed to be last."
    },
    {
      "sbg:category": "Config Inputs",
      "id": "split_l0",
      "type": "string?",
      "inputBinding": {
        "prefix": "--split-l0",
        "shellQuote": false,
        "position": 52
      },
      "label": "Split level 0",
      "doc": "Split level 0 across N jobs and set prefix of output files. Format: --split-l0 PREFIX,N."
    },
    {
      "sbg:category": "Config Inputs",
      "id": "run_l0_idx",
      "type": "int?",
      "label": "Run level 0 job",
      "doc": "Run level 0 for job K in {1..N} using master file created from '--split-l0'. Format: K"
    },
    {
      "sbg:category": "File Inputs",
      "id": "run_l1",
      "type": "File?",
      "inputBinding": {
        "prefix": "--run-l1",
        "shellQuote": false,
        "position": 54
      },
      "label": "Split level 0 master file to run level 1",
      "doc": "Run level 1 using master file from '--split-l0'."
    },
    {
      "sbg:category": "Config Inputs",
      "sbg:toolDefaultValue": "False",
      "id": "keep_l0",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--keep-l0",
        "shellQuote": false,
        "position": 55
      },
      "label": "Keep level 0 predictions",
      "doc": "Avoid deleting the level 0 predictions written on disk after fitting the level 1 models."
    },
    {
      "sbg:category": "Config Inputs",
      "sbg:toolDefaultValue": "False",
      "id": "print_prs",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--print-prs",
        "shellQuote": false,
        "position": 56
      },
      "label": "Output whole genome PRS",
      "doc": "Also output polygenic predictions without using LOCO (=whole genome PRS)."
    },
    {
      "sbg:category": "Config Inputs",
      "sbg:toolDefaultValue": "False",
      "id": "use_prs",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--use-prs",
        "shellQuote": false,
        "position": 57
      },
      "label": "Use PRS",
      "doc": "When using whole genome PRS step 1 output in '--pred'."
    },
    {
      "sbg:category": "Config Inputs",
      "sbg:toolDefaultValue": "0",
      "id": "min_info",
      "type": "float?",
      "inputBinding": {
        "prefix": "--minINFO",
        "shellQuote": false,
        "position": 58
      },
      "label": "Minimum imputation info score",
      "doc": "Minimum imputation info score (Impute/Mach R^2) for tested variants. Default: 0."
    },
    {
      "sbg:category": "Config Inputs",
      "id": "range",
      "type": "string?",
      "inputBinding": {
        "prefix": "--range",
        "shellQuote": false,
        "position": 59
      },
      "label": "Range of positions to test in step 2",
      "doc": "Specify a physical position window for variants to test in step 2. Format: CHR:MINPOS-MAXPOS."
    },
    {
      "sbg:category": "File Inputs",
      "id": "set_list",
      "type": "File?",
      "inputBinding": {
        "prefix": "--set-list",
        "shellQuote": false,
        "position": 60
      },
      "label": "Sets definition",
      "doc": "File with sets definition."
    },
    {
      "sbg:category": "File Inputs",
      "id": "extract_sets",
      "type": "File?",
      "inputBinding": {
        "prefix": "--extract-sets",
        "shellQuote": false,
        "position": 61
      },
      "label": "Extract sets file",
      "doc": "File with IDs of sets to retain in the analysis."
    },
    {
      "sbg:category": "File Inputs",
      "id": "exclude_sets",
      "type": "File?",
      "inputBinding": {
        "prefix": "--exclude-sets",
        "shellQuote": false,
        "position": 62
      },
      "label": "Exclude sets file",
      "doc": "File with IDs of sets to remove from the analysis."
    },
    {
      "sbg:category": "Config Inputs",
      "id": "extract_setlist",
      "type": "string[]?",
      "inputBinding": {
        "prefix": "--extract-setlist",
        "itemSeparator": ",",
        "shellQuote": false,
        "position": 63
      },
      "label": "Extract set list",
      "doc": "Comma separated list of sets to retain in the analysis."
    },
    {
      "sbg:category": "Config Inputs",
      "id": "exclude_setlist",
      "type": "string[]?",
      "inputBinding": {
        "prefix": "--exclude-setlist",
        "itemSeparator": ",",
        "shellQuote": false,
        "position": 64
      },
      "label": "Exclude set list",
      "doc": "Comma-separated list of sets to remove from the analysis."
    },
    {
      "sbg:category": "File Inputs",
      "id": "anno_file",
      "type": "File?",
      "inputBinding": {
        "prefix": "--anno-file",
        "shellQuote": false,
        "position": 65
      },
      "label": "Variant annotations",
      "doc": "File with variant annotations."
    },
    {
      "sbg:category": "File Inputs",
      "id": "anno_labels",
      "type": "File?",
      "inputBinding": {
        "prefix": "--anno-labels",
        "shellQuote": false,
        "position": 66
      },
      "label": "Annotation labels",
      "doc": "File with labels to annotations."
    },
    {
      "sbg:category": "File Inputs",
      "id": "mask_def",
      "type": "File?",
      "inputBinding": {
        "prefix": "--mask-def",
        "shellQuote": false,
        "position": 67
      },
      "label": "Mask definitions",
      "doc": "File with mask definitions."
    },
    {
      "sbg:category": "File Inputs",
      "id": "aaf_file",
      "type": "File?",
      "inputBinding": {
        "prefix": "--aaf-file",
        "shellQuote": false,
        "position": 68
      },
      "label": "AAF for building masks",
      "doc": "File with AAF to use when building masks."
    },
    {
      "sbg:category": "Config Inputs",
      "id": "aaf_bins",
      "type": "float[]?",
      "inputBinding": {
        "prefix": "--aaf-bins",
        "itemSeparator": ",",
        "shellQuote": false,
        "position": 69
      },
      "label": "AAF bins",
      "doc": "AAF bin cutoffs for building masks."
    },
    {
      "sbg:category": "Config Inputs",
      "sbg:toolDefaultValue": "max",
      "id": "build_mask",
      "type": [
        "null",
        {
          "type": "enum",
          "symbols": [
            "max",
            "sum",
            "comphet"
          ],
          "name": "build_mask"
        }
      ],
      "inputBinding": {
        "prefix": "--build-mask",
        "shellQuote": false,
        "position": 70
      },
      "label": "Rule to construct masks",
      "doc": "Rule to construct masks. Default: max."
    },
    {
      "sbg:category": "Config Inputs",
      "id": "singleton_carrier",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--singleton-carrier",
        "shellQuote": false,
        "position": 71
      },
      "label": "Singleton carrier",
      "doc": "Define singletons as variants with a single carrier in the sample."
    },
    {
      "sbg:category": "Config Inputs",
      "id": "write_mask",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--write-mask",
        "shellQuote": false,
        "position": 72
      },
      "label": "Write masks in PLINK format",
      "doc": "Write masks in PLINK BED/BIM/FAM format."
    },
    {
      "sbg:category": "Config Inputs",
      "id": "mask_lovo",
      "type": "string?",
      "inputBinding": {
        "prefix": "--mask-lovo",
        "shellQuote": false,
        "position": 73
      },
      "label": "Mask LOVO",
      "doc": "Apply Leave-One-Variant-Out (LOVO) scheme when building masks (<set_name>,<mask_name>,<aaf_cutoff>)."
    },
    {
      "sbg:category": "Config Inputs",
      "id": "skip_test",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--skip-test",
        "shellQuote": false,
        "position": 74
      },
      "label": "Skip test",
      "doc": "Skip computing association tests after building masks."
    },
    {
      "sbg:category": "Config Inputs",
      "id": "check_burden_files",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--check-burden-files",
        "shellQuote": false,
        "position": 75
      },
      "label": "Check inputs consistency",
      "doc": "Check annotation file, set list file and mask file for consistency."
    },
    {
      "sbg:category": "Config Inputs",
      "id": "strict_check_burden",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--strict-check-burden",
        "shellQuote": false,
        "position": 76
      },
      "label": "Exit early with inconsistent inputs",
      "doc": "Exit early if the annotation, set list and mask definition files do not match."
    },
    {
      "sbg:category": "File Inputs",
      "id": "split_l0_files",
      "type": "File[]?",
      "label": "Split L0 files to use",
      "doc": "Split L0 files to use.",
      "sbg:fileTypes": "MASTER, SNPLIST"
    },
    {
      "sbg:category": "Additional Options",
      "sbg:toolDefaultValue": "False",
      "id": "verbose",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--verbose",
        "shellQuote": false,
        "position": 41
      },
      "label": "Verbose screen output",
      "doc": "Verbose screen output."
    },
    {
      "sbg:category": "Additional Options",
      "id": "setl0",
      "type": "float[]?",
      "inputBinding": {
        "prefix": "--setl0",
        "itemSeparator": ",",
        "shellQuote": false,
        "position": 42
      },
      "label": "Set l0 ridge parameters",
      "doc": "List of ridge parameters to use when fitting models within blocks [l0]."
    },
    {
      "sbg:category": "Additional Options",
      "id": "setl1",
      "type": "float[]?",
      "inputBinding": {
        "prefix": "--setl1",
        "itemSeparator": ",",
        "shellQuote": false,
        "position": 43
      },
      "label": "Set l1 ridge parameters",
      "doc": "List of ridge parameters to use when fitting model across blocks."
    },
    {
      "sbg:category": "Additional Options",
      "id": "n_auto",
      "type": "int?",
      "inputBinding": {
        "prefix": "--nauto",
        "shellQuote": false,
        "position": 44
      },
      "label": "Number of autosomes",
      "doc": "Number of autosomal chromosomes."
    },
    {
      "sbg:category": "Additional Options",
      "id": "nb",
      "type": "int?",
      "inputBinding": {
        "prefix": "--nb",
        "shellQuote": false,
        "position": 45
      },
      "label": "Number of blocks to use",
      "doc": "Number of blocks to use."
    },
    {
      "sbg:category": "Additional Options",
      "sbg:toolDefaultValue": "30",
      "id": "n_iter",
      "type": "int?",
      "inputBinding": {
        "prefix": "--niter",
        "shellQuote": false,
        "position": 46
      },
      "label": "Maximum number of logistic regression iterations",
      "doc": "Maximum number of iterations for logistic regression. Default: 30."
    },
    {
      "sbg:category": "Additional Options",
      "sbg:toolDefaultValue": "25",
      "id": "maxstep_null",
      "type": "int?",
      "inputBinding": {
        "prefix": "--maxstep-null",
        "shellQuote": false,
        "position": 47
      },
      "label": "Maximum step size in null Firth logistic regression",
      "doc": "Maximum step size in null Firth logistic regression. Default: 25."
    },
    {
      "sbg:category": "Additional Options",
      "sbg:toolDefaultValue": "1000",
      "id": "maxiter_null",
      "type": "int?",
      "inputBinding": {
        "prefix": "--maxiter-null",
        "shellQuote": false,
        "position": 48
      },
      "label": "Maximum number of iterations in null Firth logistic regression",
      "doc": "Maximum number of iterations in null Firth logistic regression. Default: 1000."
    },
    {
      "sbg:category": "Main Options",
      "id": "cat_covar_list",
      "type": "string[]?",
      "inputBinding": {
        "prefix": "--catCovarList",
        "itemSeparator": ",",
        "shellQuote": false,
        "position": 77
      },
      "label": "Categorical covariates list",
      "doc": "Categorical covariates list."
    },
    {
      "sbg:category": "Additional Options",
      "sbg:toolDefaultValue": "10",
      "id": "max_cat_levels",
      "type": "int?",
      "inputBinding": {
        "prefix": "--maxCatLevels",
        "shellQuote": false,
        "position": 78
      },
      "label": "Maximum categorical covariates levels",
      "doc": "Maximum number of levels for categorical covariates. Default: 10."
    },
    {
      "sbg:category": "Additional Options",
      "sbg:toolDefaultValue": "False",
      "id": "force_step1",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--force-step1",
        "shellQuote": false,
        "position": 79
      },
      "label": "Force step 1",
      "doc": "Run step 1 for more than 1M variants (not recommended). Default: False."
    },
    {
      "sbg:category": "Additional Options",
      "sbg:toolDefaultValue": "False",
      "id": "force_impute",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--force-impute",
        "shellQuote": false,
        "position": 80
      },
      "label": "Force impute",
      "doc": "Keep and impute missing observations when in step 2 (default is to drop missing for each trait). Default: False."
    },
    {
      "sbg:category": "Additional Options",
      "id": "firth_se",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--firth-se",
        "shellQuote": false,
        "position": 81
      },
      "label": "Firth SE",
      "doc": "Compute SE for Firth based on effect size estimate and LRT p-value."
    },
    {
      "sbg:category": "Additional Options",
      "id": "print_pheno",
      "type": "boolean?",
      "inputBinding": {
        "prefix": "--print-pheno",
        "shellQuote": false,
        "position": 82
      },
      "label": "Print phenotype name [step 2]",
      "doc": "Print phenotype name when writing sample IDs to file (only for step 2)."
    },
    {
      "sbg:category": "Config Inputs",
      "sbg:toolDefaultValue": "False",
      "id": "debug_log",
      "type": "boolean?",
      "label": "Create debug log in task stats",
      "doc": "Create debug log in task stats."
    }
  ],
  "outputs": [
    {
      "id": "regenie_log",
      "doc": "Regenie results.",
      "label": "Regenie results",
      "type": "File?",
      "outputBinding": {
        "glob": "*_regeni*.log",
        "outputEval": "$(inheritMetadata(self, inputs.pheno_file))"
      },
      "sbg:fileTypes": "TXT, TSV"
    },
    {
      "id": "out_predictions",
      "doc": "Prediction files",
      "label": "Prediction files",
      "type": "File[]?",
      "outputBinding": {
        "glob": "${\n    if (inputs.step == '1')\n    {\n        return [\"*.loco\", \"*.loco.gz\"]\n    }\n    else\n    {\n        return '*.non_exist'\n    }\n}",
        "outputEval": "$(inheritMetadata(self, inputs.pheno_file))"
      },
      "sbg:fileTypes": "LOCO"
    },
    {
      "id": "out_pred_list",
      "doc": "File listing prediction files.",
      "label": "File listing prediction files",
      "type": "File?",
      "outputBinding": {
        "glob": "*.list",
        "outputEval": "$(inheritMetadata(self, inputs.pheno_file))"
      },
      "sbg:fileTypes": "LIST"
    },
    {
      "id": "out_regenie",
      "doc": "Step2 regenie results.",
      "label": "Step2 regenie results",
      "type": "File[]?",
      "outputBinding": {
        "glob": "*.regenie",
        "outputEval": "$(inheritMetadata(self, inputs.pheno_file))"
      },
      "sbg:fileTypes": "REGENIE"
    },
    {
      "id": "out_regenie_ids",
      "doc": "Regenie IDs files.",
      "label": "Regenie IDs files",
      "type": "File[]?",
      "outputBinding": {
        "glob": "*.regenie.ids",
        "outputEval": "$(inheritMetadata(self, inputs.pheno_file))"
      },
      "sbg:fileTypes": "IDS"
    },
    {
      "id": "out_split_l0_files",
      "doc": "Split L0 files.",
      "label": "Split L0 files",
      "type": "File[]?",
      "outputBinding": {
        "glob": "${\n    if (inputs.split_l0)\n    {\n        return inputs.split_l0.split(',')[0].concat('*')\n    }\n    else\n    {\n        return ''\n    }\n}",
        "outputEval": "$(inheritMetadata(self, inputs.pheno_file))"
      },
      "sbg:fileTypes": "MASTER, SNPLIST"
    },
    {
      "id": "out_run_l0_files",
      "doc": "Run L0 files.",
      "label": "Run L0 files",
      "type": "File[]?",
      "outputBinding": {
        "glob": "*_job*_l0_*",
        "outputEval": "$(inheritMetadata(self, inputs.pheno_file))"
      }
    },
    {
      "id": "out_masks",
      "doc": "Mask files in Plink format.",
      "label": "Mask files in Plink format",
      "type": "File[]?",
      "outputBinding": {
        "glob": "${\n    if (inputs.write_mask)\n    {\n        return '*masks*'\n    }\n    else\n    {\n        return ''\n    }\n}",
        "outputEval": "$(inheritMetadata(self, inputs.pheno_file))"
      },
      "sbg:fileTypes": "BED, BIM, FAM"
    },
    {
      "id": "out_prs",
      "doc": "If using --print-prs, files files_1.prs,...,files_P.prs will be written with the whole genome predictions (i.e. PRS) without using LOCO scheme (similar format as the .loco files). The list of these files is written to file_prs.list and can be used in step 2 with --pred and specifying flag --use-prs. Note that as these are not obtained using a LOCO scheme, association tests could suffer from proximal contamination.",
      "label": "PRS files",
      "type": "File[]?",
      "outputBinding": {
        "glob": "*.prs",
        "outputEval": "$(inheritMetadata(self, inputs.pheno_file))"
      },
      "sbg:fileTypes": "PRS, LIST"
    },
    {
      "id": "out_mask_report",
      "doc": "Check burden files report.",
      "label": "Check burden files report",
      "type": "File?",
      "outputBinding": {
        "glob": "*masks_report.txt",
        "outputEval": "$(inheritMetadata(self, inputs.pheno_file))"
      },
      "sbg:fileTypes": "TXT"
    }
  ],
  "doc": "**Regenie** is a tool for whole genome regression analysis [1,2].\n\n*A list of **all inputs and parameters** with corresponding descriptions can be found at the bottom of the page.*\n\n***Please note that any cloud infrastructure costs resulting from app and pipeline executions, including the use of public apps, are the sole responsibility of you as a user. To avoid excessive costs, please read the app description carefully and set the app parameters and execution settings accordingly.***\n\n### Common Use Cases\n\n**Regenie** can be used to perform association testing for binary and quantitative traits [1,2]. This wrapper supports both tool execution modes (step 1 and 2). The two steps should be executed together (step 1 followed by step 2).\n\nPlease consult the tool documentation [1] for details regarding input parameters and the recommended analysis flow.\n\nFor processing UK Biobank data, please consider following the recommendations [3] given by the tool authors.\n\nStep 1 of **Regenie** can be parallelized through multiple task executions [4]. To replicate this flow on the Seven Bridges platforms, run step 1 with the **Split level 0** parameter, specifying the prefix of the outputs and the desired number of jobs. The output files (**Split L0 files**) produced by this task should all be supplied as inputs (**Split L0 files to use**) for each subsequent task for individual level 0 jobs (**Run level 0 job** input parameter should be used to specify the current task index). Level 0 temporary outputs of these tasks (**Run L0 files**) should all be provided together as inputs (**Split L0 files to use**) to the final level 1 task, with the master split file given as the **Split level 0 master file to run level 1** input.\n\n### Changes Introduced by Seven Bridges\n\n* The step1 output file listing predictions (*.pred.list) (**File listing prediction files**) has been modified to strip the absolute paths from each row, leaving only file names. This was done to allow this file to be directly used as an input for step 2 analysis on the Seven Bridges platforms.\n* Input **Prediction files from step 1** was added to allow the staging of step 1 prediction outputs for use in step 2 tasks.\n* Input **Split L0 files to use** was added to allow parallelization of level 0 executions.\n* Parameters `--help` and `--helpFull` were omitted from the wrapper.\n* Parameter **Create debug log in task stats** was added to assist with troubleshooting tasks. If this input is used, the extra log can be found on the task stats page. In addition to error messages, this log will also contain redirected information from the regular tool log.\n\n### Common Issues and Important Notes\n\n* **Phenotype file**, **Step** and **Size of genotype blocks** inputs are required.\n* At least one of the **Plink files**, **Plink2 files** or **BGEN file** should be supplied.\n* **File with variant IDs to retain** and **File with variant IDs to remove** inputs are only applicable to step 1 executions.\n* Step 1 executions only support a single file containing genotypes.\n* In the **Phenotype file** all missing values should be coded as `NA`.\n* Binary traits should be coded as 0, 1, and NA for control, case, and missing respectively, unless the **Use control 1 case 2 encoding for binary traits** input is used.\n* To analyze chrX genotypes, males should be coded as 0/2 (diploid). For details on how to achieve this with **Plink**, please consult [1].\n* The same covariate file (**Covariate file**) should be used for step 1 and step 2 tasks in an analysis. No missing values are allowed in this file.\n* **File with step1 prediction files** input should be supplied for step 2 executions. The corresponding prediction files should be supplied through the **Prediction files from step 1** input.\n* By default, step 2 uses all available threads.\n* For troubleshooting common tool failures, please consult the tool FAQ page [5].\n\n### Performance Benchmarking\n\n**Regenie** performance greatly depends on the selected inputs and parameters. For details, please see the official tool documentation [1].\n\nTwo simulated datasets were used for testing: \n* sim2k - 2000 individuals, ~780k variants, 1 phenotype\n* sim485k - ~485k individuals ~500k variants (1.26 million variants for step 2), 3 phenotypes\n\n\n| Experiment type  | Duration | Cost | Instance (AWS on-demand)|\n|-----------------------|-----------------|------------|-----------------|-------------|--------------|------------------|-------------|---------------|\n| sim2k - step1  | 40 min | $0.27 + $0.10 |  c4.2xlarge 1024 GB EBS |\n| sim2k - step2  | 2 min | $0.01 + $0.01 |  c4.2xlarge 1024 GB EBS |\n| sim485k - step1  | 13 h 33 min | $20.74 + $1.86 |  c5.9xlarge 1024 GB EBS |\n| sim485k - step2  | 16 h 29 min | $25.22 + $1.11 |  c5.9xlarge 500 GB EBS |\n\n*Cost can be significantly reduced by using **spot instances**. Visit the [Knowledge Center](https://docs.sevenbridges.com/docs/about-spot-instances) for more details.* \n\n### References\n\n[1] [Regenie documentation](https://rgcgithub.github.io/regenie/)\n\n[2] [Regenie publication](https://www.biorxiv.org/content/10.1101/2020.06.19.162354v2)\n\n[3] [Regenie UK Biobank processing recommendations](https://rgcgithub.github.io/regenie/recommendations/)\n\n[4] [Regenie step 1 parallelization flow](https://github.com/rgcgithub/regenie/wiki/Further-parallelization-for-level-0-models-in-Step-1)\n\n[5] [Regenie FAQ page](https://rgcgithub.github.io/regenie/faq/)",
  "label": "Regenie",
  "arguments": [
    {
      "prefix": "--out",
      "shellQuote": false,
      "position": 1,
      "valueFrom": "${\n    if (inputs.prefix)\n    {\n        return inputs.prefix.concat('_regenie')\n    }\n    else if (inputs.in_bed)\n    {\n        return inputs.in_bed[0].nameroot.concat('_regenie')\n    }\n    else if (inputs.in_pgen)\n    {\n        return inputs.in_pgen[0].nameroot.concat('_regenie')\n    }\n    else if (inputs.in_bgen)\n    {\n        return [].concat(inputs.in_bgen)[0].nameroot.concat('_regenie')\n    }\n}"
    },
    {
      "prefix": "",
      "shellQuote": false,
      "position": 100,
      "valueFrom": "${\n    if (inputs.step == '1')\n    {\n        var pred_name = ''\n        if (inputs.prefix)\n        {\n            pred_name = inputs.prefix.concat('_regenie_pred.list')\n        }\n        else if (inputs.in_bed)\n        {\n            pred_name = inputs.in_bed[0].nameroot.concat('_regenie_pred.list')\n        }\n        else if (inputs.in_pgen)\n        {\n            pred_name = inputs.in_pgen[0].nameroot.concat('_regenie_pred.list')\n        }\n        else if (inputs.in_bgen)\n        {\n            pred_name = [].concat(inputs.in_bgen)[0].nameroot.concat('_regenie_pred.list')\n        }\n        if ((!inputs.split_l0) && (!inputs.run_l0_idx) && (!inputs.run_l1))\n        {\n            if (inputs.print_prs)\n            {\n                var temp_cmd = ' && '.concat(\"awk '{n=split($2, a, \",'\"/\"', \"); $2 = a[n]} 1' \", pred_name, ' >> clean.list && mv clean.list ', pred_name)\n                var pred_name2 = pred_name.split('_regenie_pred.list')[0].concat('_regenie_prs.list')\n                return temp_cmd.concat(\" && awk '{n=split($2, a, \",'\"/\"', \"); $2 = a[n]} 1' \", pred_name2, ' >> clean.list && mv clean.list ', pred_name2)\n            }\n            else\n            {\n                return ' && '.concat(\"awk '{n=split($2, a, \",'\"/\"', \"); $2 = a[n]} 1' \", pred_name, ' >> clean.list && mv clean.list ', pred_name)\n            }\n        }\n        else\n        {\n            return ''\n        }\n    }\n}"
    },
    {
      "prefix": "",
      "shellQuote": false,
      "position": 53,
      "valueFrom": "${\n    var cmd = ' --run-l0 '\n    if ((inputs.run_l0_idx) && (inputs.split_l0_files))\n    {\n        for (var i=0; i < inputs.split_l0_files.length; i++)\n        {\n            if (inputs.split_l0_files[i].nameext == '.master')\n            {\n                cmd = cmd.concat(inputs.split_l0_files[i].basename)\n            }\n        }\n        cmd = cmd.concat(',', inputs.run_l0_idx)\n        return cmd\n    }\n    else\n    {\n        return ''\n    }\n}"
    },
    {
      "prefix": "",
      "shellQuote": false,
      "position": 0,
      "valueFrom": "${\n    if (inputs.in_bed)\n    {\n        return '--bed '.concat(inputs.in_bed[0].nameroot)\n    }\n    else\n    {\n        return ''\n    }\n}"
    },
    {
      "prefix": "",
      "shellQuote": false,
      "position": 99,
      "valueFrom": "${\n    if (inputs.debug_log)\n    {\n        return '> debug.log 2>&1'\n    }\n    else\n    {\n        return ''\n    }\n}"
    }
  ],
  "requirements": [
    {
      "class": "ShellCommandRequirement"
    },
    {
      "class": "ResourceRequirement",
      "ramMin": "${\n    if (inputs.mem_per_job)\n    {\n        return inputs.mem_per_job\n    }\n    else\n    {\n        return 1000\n    }\n}",
      "coresMin": "${\n    if (inputs.cpu_per_job)\n    {\n        return inputs.cpu_per_job\n    }\n    else if (inputs.threads)\n    {\n        return inputs.threads\n    }\n    else\n    {\n        return 1\n    }\n}"
    },
    {
      "class": "DockerRequirement",
      "dockerPull": "images.sbgenomics.com/jrandjelovic/regenie-2-0-1:0"
    },
    {
      "class": "InitialWorkDirRequirement",
      "listing": [
        "$(inputs.in_bed)",
        "$(inputs.in_pgen)",
        "$(inputs.pred_files)",
        "$(inputs.split_l0_files)"
      ]
    },
    {
      "class": "InlineJavascriptRequirement",
      "expressionLib": [
        "\nvar setMetadata = function(file, metadata) {\n    if (!('metadata' in file)) {\n        file['metadata'] = {}\n    }\n    for (var key in metadata) {\n        file['metadata'][key] = metadata[key];\n    }\n    return file\n};\nvar inheritMetadata = function(o1, o2) {\n    var commonMetadata = {};\n    if (!o2) {\n        return o1;\n    };\n    if (!Array.isArray(o2)) {\n        o2 = [o2]\n    }\n    for (var i = 0; i < o2.length; i++) {\n        var example = o2[i]['metadata'];\n        for (var key in example) {\n            if (i == 0)\n                commonMetadata[key] = example[key];\n            else {\n                if (!(commonMetadata[key] == example[key])) {\n                    delete commonMetadata[key]\n                }\n            }\n        }\n        for (var key in commonMetadata) {\n            if (!(key in example)) {\n                delete commonMetadata[key]\n            }\n        }\n    }\n    if (!Array.isArray(o1)) {\n        o1 = setMetadata(o1, commonMetadata)\n        if (o1.secondaryFiles) {\n            o1.secondaryFiles = inheritMetadata(o1.secondaryFiles, o2)\n        }\n    } else {\n        for (var i = 0; i < o1.length; i++) {\n            o1[i] = setMetadata(o1[i], commonMetadata)\n            if (o1[i].secondaryFiles) {\n                o1[i].secondaryFiles = inheritMetadata(o1[i].secondaryFiles, o2)\n            }\n        }\n    }\n    return o1;\n};"
      ]
    }
  ],
  "sbg:projectName": "SBG Public Data",
  "sbg:revisionsInfo": [
    {
      "sbg:revision": 0,
      "sbg:modifiedBy": "admin",
      "sbg:modifiedOn": 1618329626,
      "sbg:revisionNotes": "Copy of jrandjelovic/regenie-dev/regenie-2-0-1-cwl1-1/19"
    },
    {
      "sbg:revision": 1,
      "sbg:modifiedBy": "admin",
      "sbg:modifiedOn": 1618329726,
      "sbg:revisionNotes": "cwltool compatibility"
    },
    {
      "sbg:revision": 2,
      "sbg:modifiedBy": "admin",
      "sbg:modifiedOn": 1618329726,
      "sbg:revisionNotes": "benchmarking table; description updates"
    },
    {
      "sbg:revision": 3,
      "sbg:modifiedBy": "admin",
      "sbg:modifiedOn": 1618329726,
      "sbg:revisionNotes": "publishing checks"
    },
    {
      "sbg:revision": 4,
      "sbg:modifiedBy": "admin",
      "sbg:modifiedOn": 1618387934,
      "sbg:revisionNotes": "categories"
    }
  ],
  "sbg:image_url": null,
  "sbg:toolkit": "regenie",
  "sbg:toolkitVersion": "2.0.1",
  "sbg:toolAuthor": "Joelle Mbatchou",
  "sbg:license": "MIT",
  "sbg:links": [
    {
      "id": "https://rgcgithub.github.io/regenie/",
      "label": "Homepage"
    },
    {
      "id": "https://github.com/rgcgithub/regenie",
      "label": "Source Code"
    },
    {
      "id": "https://github.com/rgcgithub/regenie/releases/tag/v1.0.5.8-newest",
      "label": "Download"
    },
    {
      "id": "https://www.biorxiv.org/content/10.1101/2020.06.19.162354v2",
      "label": "Publication"
    },
    {
      "id": "https://rgcgithub.github.io/regenie/options/",
      "label": "Documentation"
    }
  ],
  "sbg:categories": [
    "CWL1.1",
    "GWAS",
    "Genomics"
  ],
  "sbg:expand_workflow": false,
  "sbg:appVersion": [
    "v1.1"
  ],
  "id": "https://api.sb.biodatacatalyst.nhlbi.nih.gov/v2/apps/admin/sbg-public-data/regenie-2-0-1-cwl1-1/4/raw/",
  "sbg:id": "admin/sbg-public-data/regenie-2-0-1-cwl1-1/4",
  "sbg:revision": 4,
  "sbg:revisionNotes": "categories",
  "sbg:modifiedOn": 1618387934,
  "sbg:modifiedBy": "admin",
  "sbg:createdOn": 1618329626,
  "sbg:createdBy": "admin",
  "sbg:project": "admin/sbg-public-data",
  "sbg:sbgMaintained": false,
  "sbg:validationErrors": [],
  "sbg:contributors": [
    "admin"
  ],
  "sbg:latestRevision": 4,
  "sbg:publisher": "sbg",
  "sbg:content_hash": "a74c543718bd72925ce1e82ceb9354779af579e5eeb0ec252658d0c231213c985"
}
