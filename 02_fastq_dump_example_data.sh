#!/bin/bash
#SBATCH --partition=day
#SBATCH --output=job_fastq_dump_%j.out
#SBATCH --error=job_fastq_dump_%j.err
#SBATCH --mem=1G
#SBATCH --cpus-per-task=1

source activate sqa

# get three example datasets from A. thaliana
fastq-dump -X 1000000 --split-3 -O data SRR21814487
fastq-dump -X 2500000 --split-3 -O data SRR21814488
fastq-dump -X 5000000 --split-3 -O data SRR21814489

