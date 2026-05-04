#!/bin/bash
set -e

source ~/.bashrc
conda activate base

FOLDS=(H028)
Ns=(2 4 )
N_BOOTSTRAP=5

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_allcellstype_raw_minimal_codinggenes_condition_alpha_satu_L5Osplit_split_alpha_N_B.h5ad


DATA_FILE="$MY_DATA_FILE"
TMP_DIR="/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/temp_p1.h5ad"

work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/ACT_l50
run_file_name=finetune_l5O_raw_N_B_28_1
all_cells=predict_alpha_L5O_hvg4096



for sample in "${FOLDS[@]}"; do
   echo "Processing $sample"
    column="L5O_${sample}"   # define the column here in bash

    python - <<EOF
import scanpy as sc
adata = sc.read_h5ad("$MY_DATA_FILE")

column = "$column"   # passed in from bash
adata_sub = adata[adata.obs[column] == 'dev'].copy()
adata_sub.write("/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/tmp_p1.h5ad")
EOF

    for N in "${Ns[@]}"; do
      for B in $(seq 1 $N_BOOTSTRAP); do
        col="L5O_${sample}_N${N}_B${B}"
            # Run bmfm on subset
    	bmfm-targets-run -cn predict_l5o_N_B_28_1 \
     		input_file=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/tmp_p1.h5ad \
     		working_dir=${work_dir}/${run_file_name}/${all_cells}/${col}_${run_file_name}  \
     		data_module.max_length=4096 \
     		checkpoint=${work_dir}/${run_file_name}/${col}_${run_file_name}/last.ckpt \

      done
   done 
done 

echo "All done"
