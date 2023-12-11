#!/bin/bash
#SBATCH --job-name=cford_pd1_dist
#SBATCH --partition=Orion
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --constraint=skylake
#SBATCH --time=2:00:00

export input_csv=./experiments.csv

while IFS="," read -r antibody_id experiment_path
do
  echo "Antibody ID: $antibody_id"
  echo "Experiment Path: $experiment_path"
  echo ""

  JOBID=$(sbatch --parsable submit_docking_job.sh $antibody_id $experiment_path)

done < <(tail -n +2 $input_csv)