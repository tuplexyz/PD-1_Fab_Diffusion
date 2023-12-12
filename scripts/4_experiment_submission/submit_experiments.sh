#!/bin/bash
#SBATCH --job-name=cford_pd1_dist
#SBATCH --partition=Orion
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --constraint=skylake
#SBATCH --time=2:00:00

module load singularity

export PROJECT_DIR=/users/$USER/PD1_Fab_Diffusion
export input_csv=./experiments.csv

while IFS="," read -r antibody_id experiment_path
do
  echo "Antibody ID: $antibody_id"
  echo "Experiment Path: $experiment_path"
  echo ""

  JOBID=$(sbatch --parsable $PROJECT_DIR/scripts/4_experiment_submission/start_docking_job.sh $antibody_id $experiment_path)

done < <(tail -n +2 $input_csv)