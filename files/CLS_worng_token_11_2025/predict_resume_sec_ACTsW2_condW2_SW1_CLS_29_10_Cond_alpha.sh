#!/bin/bash

#export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_from_start_with_metadata_allcelltypes_minimal_codinggenes_condition_alpha_L5Osplit.h5ad
export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_from_start_with_metadata_allcelltypes_minimal_codinggenes_condition_alpha_satu_alpha.h5ad

work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/CLS_tokens

run_file_name=ACTsW2_condW2_SW1_CLS_29_10

#############
# predict from celltype on all cellstype for claerml visu 16 11

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_from_start_with_metadata_allcelltypes_minimal_codinggenes_condition_alpha_L5Osplit.h5ad

pooling=CT_COL
all_cells=predict_allcells_${pooling}

bmfm-targets-run -cn predict_resume_ACTsW2_condW2_SW1_CLS_29_10 \
     input_file=$MY_DATA_FILE \
     file_name=${run_file_name}_allalpha_resume_sec${pooling} \
     working_dir=${work_dir}/${run_file_name}_resume_sec/${all_cells}  \
     ++data_module.rda_transform=auto_align \
     data_module.log_normalize_transform=false \
     data_module.max_length=4096 \
     trainer.pooling_method=1 \
     batch_column_name=celltypes \
     checkpoint=${work_dir}/${run_file_name}/${run_file_name}/last-v2.ckpt 



exit


# 16 11 
pooling=Cond
all_cells=predict_allalpha_${pooling}

bmfm-targets-run -cn predict_resume_ACTsW2_condW2_SW1_CLS_29_10 \
     input_file=$MY_DATA_FILE \
     file_name=${run_file_name}_allalpha_resume_sec${pooling} \
     working_dir=${work_dir}/${run_file_name}_resume_sec/${all_cells}  \
     ++data_module.rda_transform=auto_align \
     data_module.log_normalize_transform=false \
     data_module.max_length=4096 \
     trainer.pooling_method=2 \
     checkpoint=${work_dir}/${run_file_name}/${run_file_name}/last-v2.ckpt 

echo "All done"


