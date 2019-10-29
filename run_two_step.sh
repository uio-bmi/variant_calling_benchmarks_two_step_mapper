
#map_linear 80 /data/bioinf/human_1pc/hg19_chr1-Y.bwa-mem2.fa /data/bioinf/human_1pc/hg19_chr1-Y.fa downsampled.fasta > linear.sam

two_step_map 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,X 60 /data/bioinf/human_1pc/ downsampled.fasta 0 5 /data/bioinf/human_1pc/hg19_chr1-Y.bwa-mem2.fa /data/bioinf/human_1pc/hg19_chr1-Y.fa 



cat test.sam two_step_final.sam | awk -v OFS="\t" '$1=$1' | sambamba view -S -f bam /dev/stdin  > two_step.bam

sambamba sort -t 50 two_step.bam
echo "Indexing"
sambamba index -t 50 -p two_step.sorted.bam

rm /home/ivar/dev/graphtyper-pipelines/results/21/*

# For some reason the config file must be in the graphtyper dir (?)
cp graphtyper_config.sh /home/ivar/dev/graphtyper-pipelines/.
bash /home/ivar/dev/graphtyper-pipelines/make_graphtyper_pipeline.sh /data/bioinf/variant_calling_analysis/two_step.sorted.bam /home/ivar/dev/graphtyper-pipelines/graphtyper_config.sh | bash

graphtyper vcf_concatenate /home/ivar/dev/graphtyper-pipelines/results/21/*.vcf.gz | bgzip -c > two_step_variants.vcf.gz

/root/hap.py-install/bin/hap.py /home/ivar/dev/graphmapping/data/HG002_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-22_v.3.3.2_highconf_triophased_chr21.vcf.gz two_step_variants.vcf.gz  -r /data/bioinf/human_1pc/hg19_chr1-Y.fa  -o hap.py-output


