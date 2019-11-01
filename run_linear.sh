graph_dir=$1
bwa_mem2_index=$2

map_linear 80 $bwa_mem2_index $graph_dir/hg19_chr1-Y.fa downsampled.fasta > linear.sam
cat header.sam linear.sam | awk -v OFS="\t" '$1=$1' | sambamba view -S -f bam /dev/stdin  > linear.bam
