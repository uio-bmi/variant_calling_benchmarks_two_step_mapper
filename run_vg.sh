
#vg1.17 map -t 70 -f downsampled.fasta --surject-to BAM -g /data/bioinf/human_1pc/wg.gcsa -x /data/bioinf/human_1pc/wg_old.xg > vg.sam
#echo "Sorting"
#sambamba sort -t 50 vg.bam
#echo "Indexing"
#sambamba index -t 50 -p vg.sorted.bam

#rm /home/ivar/dev/graphtyper-pipelines/results/21/*

# For some reason the config file must be in the graphtyper dir (?)
cp graphtyper_config.sh /home/ivar/dev/graphtyper-pipelines/.
#bash /home/ivar/dev/graphtyper-pipelines/make_graphtyper_pipeline.sh /data/bioinf/variant_calling_analysis/vg.sorted.bam /home/ivar/dev/graphtyper-pipelines/graphtyper_config.sh | bash

#graphtyper vcf_concatenate /home/ivar/dev/graphtyper-pipelines/results/21/*.vcf.gz | bgzip -c > vg_variants.vcf.gz

/root/hap.py-install/bin/hap.py /home/ivar/dev/graphmapping/data/HG002_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-22_v.3.3.2_highconf_triophased_chr21.vcf.gz vg_variants.vcf.gz  -r /data/bioinf/human_1pc/hg19_chr1-Y.fa  -o hap.py-output
