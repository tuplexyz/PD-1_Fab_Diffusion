#!/bin/bash
#SBATCH --job-name=cford_pd1_iter_$1
#SBATCH --partition=Orion
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=64
#SBATCH --constraint=epyc
#SBATCH --mem=500gb
#SBATCH --time=8:00:00

export SINGULARITY_CONTAINER_HOME=/users/$USER/PD1_Fab_Diffusion

singularity run $SINGULARITY_CONTAINER_HOME/haddock.sif

cd $2
csh ./run-docking.csh