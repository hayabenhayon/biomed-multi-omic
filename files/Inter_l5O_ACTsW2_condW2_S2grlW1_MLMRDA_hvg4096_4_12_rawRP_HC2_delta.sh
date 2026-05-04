#!/bin/bash
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_allcellstype_rawRP_minimal_codinggenes_condition_alphadelta_satu_L5Osplit_split_HC2_hvg6144_delta.h5ad

work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/ACT_l50

run_file_name=ACTsW2_condW2_S2grlW1_MLMRDA_hvg4096_4_12_rawRP_HC2_delta

all_cells=Interpret_20_01_4096_lb

for sample in H032 H071; do # H123 H113 H087 H020 H021 H028 H064 H084 H023 H055
    echo "Processing $sample"
    column="L5OHC_${sample}"   # define the column here in bash

    python - <<EOF
import scanpy as sc
adata = sc.read_h5ad("$MY_DATA_FILE")

column = "$column"   # passed in from bash
adata_sub = adata[adata.obs[column] == 'dev'].copy()
adata_sub.write("/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/tmp2.h5ad")
EOF

    # Run bmfm on subset
    bmfm-targets-run -cn Inter_L5O_ACTsW_condW_SgrlW_MLMRDA_10_9_delta \
     input_file=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/tmp2.h5ad \
     working_dir=${work_dir}/${run_file_name}/${all_cells}/${sample}_${run_file_name}  \
     ++data_module.rda_transform=auto_align \
     checkpoint=${work_dir}/${run_file_name}/${sample}_${run_file_name}/last.ckpt 

    echo "Finished $sample"
done

echo "All done"


