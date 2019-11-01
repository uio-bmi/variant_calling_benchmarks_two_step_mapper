graphtyper_pipelines_dir=$1
truth_file=$2
linear_ref=$3

sambamba sort mapped.bam
sambamba index -p mapped.sorted.bam

# Must always delete old graphtyper-data first if exists
rm -f $graphtyper_pipelines_dir/results/21/*

# For some reason the config file must be in the graphtyper dir (?)
cp graphtyper_config.sh $graphtyper_pipelines_dir/.

# Run graphtyper, and hap.py
bash $graphtyper_pipelines_dir/make_graphtyper_pipeline.sh vg.sorted.bam $graphtyper_pipelines_dir/graphtyper_config.sh | bash
graphtyper vcf_concatenate $graphtyper_pipelines_dir/results/21/*.vcf.gz | bgzip -c > variants.vcf.gz
hap.py $truth_file variants.vcf.gz  -r $linear_ref -o hap.py-output

