#!/bin/bash

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_allcellstype_raw_minimal_codinggenes_condition_alpha_satu_L5Osplit_split_alpha.h5ad

work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/CLS_tokens

run_file_name=finetune_ACTsW2_condW2_SW1_grl_CLS_24_11


# predict from condition


#pooling=Cond_COL_e10
pooling=Cond_COL_e24

all_cells=predict_allalpha_${pooling}

bmfm-targets-run -cn predict_finetune_ACTsW2_condW2_SW1_grl_CLS_24_11 \
     input_file=$MY_DATA_FILE \
     file_name=${run_file_name}_${all_cells} \
     working_dir=${work_dir}/${run_file_name}/${all_cells}  \
     data_module.max_length=4096 \
     trainer.pooling_method=2  \
     checkpoint=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/CLS_tokens/finetune_ACTsW2_condW2_SW1_CLS_24_11/copy_epoch24_25_11/last.ckpt


#pooling=sam_COL_e10
pooling=sam_COL_e24


all_cells=predict_allalpha_${pooling}

bmfm-targets-run -cn predict_finetune_ACTsW2_condW2_SW1_grl_CLS_24_11 \
     input_file=$MY_DATA_FILE \
     file_name=${run_file_name}_${all_cells} \
     working_dir=${work_dir}/${run_file_name}/${all_cells}  \
     data_module.max_length=4096 \
     trainer.pooling_method=4 \
     checkpoint=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/CLS_tokens/finetune_ACTsW2_condW2_SW1_CLS_24_11/copy_epoch24_25_11/last.ckpt


echo "All done"


