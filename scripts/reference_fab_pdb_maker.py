## Fab PDB Maker with ImmuneBuilder's ABodyBuilder2
## Source: https://github.com/oxpig/ImmuneBuilder

import os
import pandas as pd
from ImmuneBuilder import ABodyBuilder2

## Load in Candidates
task_grid = pd.read_excel('PD1_Candidates.xlsx')

## Initialize the predictor
predictor = ABodyBuilder2()

## Create PDBs
root_path = './docking/inputs/PDBs/candidates/'

for index, antibody in task_grid.iterrows():
    if antibody['antibody_sequence_source'] == 'TheraSAbDab':
        print(f"Making PDB for: {antibody['antibody_id']}...\n")
        experiment_path = f"{root_path}{antibody['antibody_id']}/"
        os.makedirs(experiment_path, exist_ok=True)
        output_file = f"{experiment_path}{antibody['antibody_id']}.pdb"
        sequences = {
            'H': antibody['h_chain'],
            'L': antibody['l_chain']
        }
        antibody = predictor.predict(sequences)
        antibody.save(output_file)