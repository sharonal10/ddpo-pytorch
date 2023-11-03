#!/bin/bash

# note: run this file with sbatch <filename> to submit to slurm. submits one at a time, necessary as we need to make changes each time. may add argparser in future to support multiple runs
#change the job name, change the things marked change. 
#SBATCH --time=96:00:00
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:3090:1
#SBATCH --mem=30G
#SBATCH --ntasks=1
#SBATCH --nodes=1-1
#SBATCH --exclude=viscam1,viscam5,viscam7

#SBATCH --job-name="fm_ddpo-11_03-telephone-sks"
#SBATCH --output=/viscam/u/sharonal/data/sbatch_sweep_out/%A_%a_%j_%x.log

#SBATCH --account=viscam
#SBATCH --partition=viscam
#SBATCH --mail-user=sharonal@stanford.edu
#SBATCH --mail-type=END,FAIL

echo "SLURM_JOBID=$SLURM_JOBID"
echo "SLURM_ARRAY_TASK_ID=$SLURM_ARRAY_TASK_ID"
echo "SLURM_JOB_NODELIST=$SLURM_JOB_NODELIST"
echo "SLURM_NNODES=$SLURM_NNODES"

source /sailhome/sharonal/.bashrc
#conda deactivate
# actenv XX_CONDA_ENV
conda activate ddpo2

cd /viscam/projects/langint/sharonal/ddpo-pytorch || exit

PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python accelerate launch scripts/train.py

echo "sbatch job done"