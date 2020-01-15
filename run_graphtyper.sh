graphtyper_pipelines_dir=$1
truth_file=$2
linear_ref=$3
bam_file_base=$4

#sambamba sort $bam_file_base.bam
#sambamba index -p $bam_file_bas.sorted.bam

# Must always delete old graphtyper-data first if exists
rm -f $graphtyper_pipelines_dir/results/*/*

# For some reason the config file must be in the graphtyper dir (?)
cp graphtyper_config.sh $graphtyper_pipelines_dir/.

# Run graphtyper, and hap.py
echo "Running graphtyper"
bash $graphtyper_pipelines_dir/make_graphtyper_pipeline.sh $bam_file_base.sorted.bam $graphtyper_pipelines_dir/graphtyper_config.sh | parallel -j 60

graphtyper vcf_concatenate $graphtyper_pipelines_dir/results/*/*.vcf.gz | bgzip -c > ${bam_file_base}_variants.vcf.gz
echo "Running happy"
/root/hap.py-install/bin/hap.py $truth_file ${bam_file_base}_variants.vcf.gz  -r $linear_ref -o hap.py-output-$bam_file_base -f confident.bed

