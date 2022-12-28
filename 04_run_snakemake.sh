#!/bin/bash
#SBATCH --partition=day
#SBATCH --output=job_run_snakemake_%j.out
#SBATCH --error=job_run_snakemake_%j.err
#SBATCH --mem=64G
#SBATCH --cpus-per-task=3

source activate sqa

snakemake  --cores 3 --use-conda 

