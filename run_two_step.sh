graph_dir=$1
bwa_mem2_index=$2

map_linear 80 $bwa_mem2_index $graph_dir/hg19_chr1-Y.fa downsampled.fasta  > linear.sam
two_step_map 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,X 60 $graph_dir downsampled.fasta 0 5 $bwa_mem2_index $graph_dir/hg19_chr1-Y.fa
cat header.sam two_step_final.sam | awk -v OFS="\t" '$1=$1' | sambamba view -S -f bam /dev/stdin  > mapped.bam


