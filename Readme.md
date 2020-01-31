# Benchmarking of variant calling a on NA24385
This repository contains code, instructions and links to data for reproducing the variant calling analysis presented in the manuscript "Assessing graph-based read mappers against a novel baseline approach highlights strengths and weaknesses of the current generation of methods".

# Reproduce the experiments
## 1) Dependencies
There are a lot of different tools needed to run the benchmarks, e.g. Graphtyper, Hap.py, vg etc. The easiest way to get all these is 
to use the Docker repository [available here](https://github.com/uio-bmi/graph_mapping_benchmarking). Alternatively,
have a look at [this dockerfile](https://github.com/uio-bmi/graph_mapping_benchmarking/blob/master/Dockerfile) to see
which software is needed and install them manually.

## 2) Download the data
There are only two data file needed for reproducing the analysis (a fasta file with reads and a vcf file with truth variant calls).
The truth vcf file is available from NCBI [here](http://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/AshkenazimTrio/HG002_NA24385_son/NISTv3.3.2/GRCh37/HG002_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-22_v.3.3.2_highconf_triophased.vcf.gz).
The fasta file used to run the linear reference genome benchmarks is availale [here](https://zenodo.org/record/3523340/files/downsampled.fasta.gz?download=1). Download these two files.

You also need a bed file of "confident regions". This file is for simplicity included in this repository (confident.bed).

You will also need vg graphs and Offset-based graphs. All these are available here: https://zenodo.org/record/2586090/files/human_pruned_1pc.tar.gz?download=1.
Extract the gz file after download.



# Run the analysis
Init a variable pointing to your graphtyper-pipelines installation:
```bash
graphtyper_pipelines_dir=/path/to/dir
```

Assuming you have the `downsampled.fasta` file and the `HG002_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-22_v.3.3.2_highconf_triophased_chr21.vcf.gz`
in the directory you are standing, and that the graph directory is stored in a variable `graph_dir=/path/to/downloaded/graphdir/`,
you can run variant calling with the different tools like this:

### vg
```bash
./run_vg.sh $graph_dir
./run_graphtyper.sh $graphtyper_pipelines_dir $truth_file
```

### Two step mapper
For this run, you will additionally need a BWA-MEM2 index.
```bash
./run_two_step.sh $graph_dir /path/to/bwa-mem2/index.fa
./run_graphtyper.sh $graphtyper_pipelines_dir $truth_file
```

### Linear mapper
For this run, you will additionally need a BWA-MEM2 index.
```bash
./run_linear.sh $graph_dir /path/to/bwa-mem2/index.fa
./run_graphtyper.sh $graphtyper_pipelines_dir $truth_file
```

For each run, hap.py will print the resulting table to the terminal.
