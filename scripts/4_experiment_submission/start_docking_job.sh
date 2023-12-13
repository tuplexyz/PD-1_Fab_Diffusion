#!/bin/bash
#SBATCH --job-name=cford_pd1_iter_$1
#SBATCH --partition=Orion
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=36
#SBATCH --time=16:00:00

## Set the main project directory
export SINGULARITY_CONTAINER_HOME=/users/$USER/PD1_Fab_Diffusion

## Set the experiments subdirectory
EXP_DIR=$SINGULARITY_CONTAINER_HOME/docking/inputs/experiments

## Set path to HADDOCK .sif file
SIF=$SINGULARITY_CONTAINER_HOME/haddock.sif

## Define temp directories
export TMP=/scratch/$USER/tmp/
export TMPDIR=/scratch/$USER/tmp/

## Run HADDOCK experiment in container, pointing to the appropriate directory
singularity run --cleanenv $SIF /bin/csh $EXP_DIR/$1/run-docking.csh $EXP_DIR/$1