# EvoDiff-Based Diffusion of novel, PD1-targeting Fab Structures


## Steps:
1. Generate Sequences using EvoDiff
2. Generate Structures using AlphaFold2
3. Renumber PDB files of structures in PyMol
    - Renumber L chains: `alter (chain L),resi=str(int(resi)+1000)`
4. Detect CDR loop residues
5. Generate HADDOCK experiment files
6. Submit HADDOCK experiments to HPC
7. Collect best docked PDB structure and metrics for each experiment
