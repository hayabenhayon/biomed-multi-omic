#!/bin/bash

#export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_from_start_with_metadata_allcelltypes_minimal_codinggenes_condition_alpha_L5Osplit.h5ad
#export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_from_start_with_metadata_allcelltypes_minimal_codinggenes_condition_alpha_sub700_L5Osplit_hvg4096.h5ad
export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_from_start_with_metadata_allcelltypes_minimal_codinggenes_condition_alpha_L5Osplit_recent.h5ad

work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/ACT_l50

run_file_name=del

all_cells=del

for sample in H032 ; do
    echo "Processing $sample"
    column="L5O_${sample}"   # define the column here in bash

    python - <<EOF
import scanpy as sc
adata = sc.read_h5ad("$MY_DATA_FILE")

column = "$column"   # passed in from bash
adata_sub = adata[adata.obs[column] == 'dev'].copy()
adata_sub.write("/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/tmp2.h5ad")
EOF

    # Run bmfm on subset
    bmfm-targets-run -cn predict_L5O_ACTs_recent_MLMRDA_28_9 \
     input_file=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/tmp2.h5ad \
     working_dir=${work_dir}/${run_file_name}/${all_cells}/${sample}_${run_file_name}  \
     ++data_module.rda_transform=auto_align \
     data_module.log_normalize_transform=false \
     data_module.max_length=4096 \
     checkpoint=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/ACT_l50/ACTs_recent_MLMRDA_28_9/H032_ACTs_recent_MLMRDA_28_9/last.ckpt \

    echo "Finished $sample"
done

echo "All done"


