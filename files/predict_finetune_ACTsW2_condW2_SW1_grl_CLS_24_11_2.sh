#!/bin/bash

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_allcellstype_raw_minimal_codinggenes_condition_alpha_satu_L5Osplit_split_alpha.h5ad

#++data_module.rda_transform=auto_align \
#data_module.log_normalize_transform=false \

work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/CLS_tokens

run_file_name=finetune_ACTsW2_condW2_SW1_grl_CLS_24_11

###
# for gender on gender 
#pooling=Gen_COL_e10
pooling=Gen_COL_e24
all_cells=predict_allalpha_${pooling}

bmfm-targets-run -cn predict_finetune_ACTsW2_condW2_SW1_grl_CLS_24_11 \
     input_file=$MY_DATA_FILE \
     file_name=${run_file_name}_${all_cells} \
     working_dir=${work_dir}/${run_file_name}/${all_cells}  \
     data_module.max_length=4096 \
     trainer.pooling_method=3 \
     batch_column_name=Gender \
     checkpoint=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/CLS_tokens/finetune_ACTsW2_condW2_SW1_CLS_24_11/copy_epoch24_25_11/last.ckpt



# for celltypes on all celltypes
export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_allcellstype_raw_minimal_codinggenes_condition_alpha_satu_sub700_L5Osplit_split.h5ad

#pooling=CT_COL_e10

pooling=CT_COL_e24
all_cells=predict_allCT_${pooling}

bmfm-targets-run -cn predict_finetune_ACTsW2_condW2_SW1_grl_CLS_24_11 \
     input_file=$MY_DATA_FILE \
     file_name=${run_file_name}_${all_cells} \
     working_dir=${work_dir}/${run_file_name}/${all_cells}  \
     data_module.max_length=4096 \
     trainer.pooling_method=1 \
     batch_column_name=celltypes  \
     checkpoint=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/CLS_tokens/finetune_ACTsW2_condW2_SW1_CLS_24_11/copy_epoch24_25_11/last.ckpt


echo "All done"

