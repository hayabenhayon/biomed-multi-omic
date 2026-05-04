#!/bin/bash

#export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_from_start_with_metadata_allcelltypes_minimal_codinggenes_condition_alpha_L5Osplit.h5ad
export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_from_start_with_metadata_allcelltypes_minimal_codinggenes_condition_alpha_L5Osplit_hvg4096.h5ad

work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/ACT_l50
run_file_name=ACTs_cond_S1_5grl_MLMRDA_15_9

all_cells=predict_allcells_L5O_hvg4096

for sample in H032 H071 H123 H055 H113 H087 H020 H021 H028 H064 H084 H023 ; do
    echo "Processing $sample"
    column="L5O_${sample}"   # define the column here in bash

    python - <<EOF
import scanpy as sc
adata = sc.read_h5ad("$MY_DATA_FILE")

column = "$column"   # passed in from bash
adata_sub = adata[adata.obs[column] == 'dev'].copy()
adata_sub.write("/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/tmp.h5ad")
EOF

    # Run bmfm on subset
    bmfm-targets-run -cn predict_L5O_ACTsW_condW_SgrlW_MLMRDA_10_9 \
     input_file=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/tmp.h5ad \
     gradient_reversal_coefficient=1.5 \
     working_dir=${work_dir}/${run_file_name}/${all_cells}/${sample}_${run_file_name}  \
     ++data_module.rda_transform=auto_align \
     data_module.log_normalize_transform=false \
     data_module.max_length=4096 \
     checkpoint=${work_dir}/${run_file_name}/${sample}_${run_file_name}/last.ckpt \

    echo "Finished $sample"
done

echo "All done"


