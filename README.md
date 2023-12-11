# EvoDiff-Based Diffusion of novel, PD1-targeting Fab Structures

<h3 align="right">Tuple, LLC</h3>

## Steps:
1. Generate Sequences using EvoDiff
2. Generate Structures using AlphaFold2
3. Renumber PDB files of structures in PyMol
4. Detect CDR loop residues
5. Generate HADDOCK experiment files
6. Submit HADDOCK experiments to HPC
    - bash `./scripts/4_experiment_submission/submit_experiments.sh`
7. Collect best docked PDB structure and metrics for each experiment
