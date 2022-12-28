# Sequencing library assessment

Snakemake pipeline to assess sequencing libraries using kmer and kraken species diversity accumulation curves. 

```
# git clone
git clone https://github.com/o-william-white/sequencing-library-assessment

# cd
cd sequencing-library-assessment/
```

Scripts 01 - 05 will:
 - set up the conda env using mamba
 - download example data from NCBI
 - write an example samples.csv
 - run the snakemake pipeline
 - create DAG 
 
To run the pipeline on your own data, simply edit the ```config/samples.csv``` file to reflect the sample names and paths to forward and reverse reads for your own data and run the script ```04_run_snakemake.sh```.
 
 By default the main output will be a png plot written to ```results/accumulation_curves/plot.png```
