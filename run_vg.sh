vg_gcsa=$1
vg_xg=$2

vg map -f downsampled.fasta --surject-to BAM -g $vg_gcsa -x $vg_xg


