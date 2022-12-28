
source activate sqa

snakemake --dag results/accumulation_curves/plot.png | dot -Tsvg > dag.svg

