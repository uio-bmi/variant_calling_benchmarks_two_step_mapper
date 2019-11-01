graph_dir=$1
vg_xg=$2

vg map -f downsampled.fasta --surject-to BAM -g $graph_dir/wg.gcsa -x $graph_dir/vg.xg > mapped.bam


