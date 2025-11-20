#!/bin/bash --norc
#SBATCH --job-name=LigandMPNN
#SBATCH --partition=gpu-a100
#SBATCH --account=genome-center-grp
#SBATCH --time=12:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --output=logs/ligandMPNN_%A_%a.out
#SBATCH --error=logs/ligandMPNN_%A_%a.err

export TORCH_HOME=/quobyte/jbsiegelgrp/software/LigandMPNN/.cache

module load conda/latest

eval "$(conda shell.bash hook)"

conda activate /quobyte/jbsiegelgrp/software/envs/ligandmpnn_env

# Setup paths
LIGANDMPNN_DIR=/quobyte/jbsiegelgrp/software/LigandMPNN
PDB_PATH=/quobyte/jbsiegelgrp/marco/ligandmpnn/ml_bootcamp/input/1BC8.pdb

# Activate environment and run
cd $LIGANDMPNN_DIR
python run.py \
    --model_type "ligand_mpnn" \
    --pdb_path $PDB_PATH \
    --batch_size 2 \
    --number_of_batches 3 \
    --temperature 0.05 \
    --fixed_residues "C1 C2 C3 C4 C5 C6 C7 C8 C9 C10" \
    --out_folder /quobyte/jbsiegelgrp/marco/ligandmpnn/ml_bootcamp/output
