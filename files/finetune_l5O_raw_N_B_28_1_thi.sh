#!/bin/bash
set -e

source ~/.bashrc
conda activate base

FOLDS=(H123 H020 H021)
Ns=(2 4 8 16 32 64 128 256 512 1024)
N_BOOTSTRAP=5

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_allcellstype_raw_minimal_codinggenes_condition_alpha_satu_L5Osplit_split_alpha_N_B.h5ad


DATA_FILE="$MY_DATA_FILE"
TMP_DIR="/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/temp3.h5ad"

work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/ACT_l50
run_file_name=finetune_l5O_raw_N_B_28_1



for sample in "${FOLDS[@]}"; do
  echo "Processing fold $sample"

  python - <<EOF
import scanpy as sc
import subprocess
from pathlib import Path

adata = sc.read_h5ad("$DATA_FILE")

fold = "$sample"
Ns = [2, 4, 8, 16, 32, 64, 128, 256, 512, 1024]
N_BOOTSTRAP = $N_BOOTSTRAP
tmp_dir = Path("$TMP_DIR")

work_dir="$work_dir"
run_file_name="$run_file_name"



for N in Ns:
    for B in range(1, N_BOOTSTRAP + 1):

        col = f"L5O_{fold}_N{N}_B{B}"
        print(f"  Running {col}")

        if col not in adata.obs:
            raise ValueError(f"Missing column {col}")

        # subset out ignore
        adata_sub = adata[adata.obs[col] != "ignore"].copy()

        # sanity check
        vc = adata_sub.obs[col].value_counts()
        if "train" not in vc or "dev" not in vc:
            raise ValueError(f"Bad split in {col}: {vc}")

        adata_sub.write("/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/tmp3.h5ad")

        cmd = f"""
bmfm-targets-run -cn finetune_l5o_N_B_28_1 \
  L5O_sample={col} \
  file_name={run_file_name} \
  input_file=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/tmp3.h5ad \
  split_column_name={col} \
  work_path={work_dir}/{run_file_name} \
  data_module.max_length=4096 \
  data_module.batch_size=8 \
  task.max_epochs=10
"""
        subprocess.run(cmd, shell=True, check=True)
EOF

done
echo "All samples done"


    
      



