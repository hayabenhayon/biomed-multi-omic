#!/bin/bash

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_allcellstype_rawXY_minimal_codinggenes_condition_alpha_satu_L5Osplit_split_alpha.h5ad

#++data_module.rda_transform=auto_align \
#data_module.log_normalize_transform=false \

work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/CLS_tokens

run_file_name=finetune_ACTsW2_condW2_SW1_grl_CLS_XY_26_11

###
# for gender on gender 
#pooling=Gen_COL_e10

all_cells=predict_allalpha_${pooling}

bmfm-targets-run -cn predict_finetune_ACTsW2_condW2_SW1_grl_CLS_24_11 \
     input_file=$MY_DATA_FILE \
     file_name=${run_file_name}_${all_cells} \
     working_dir=${work_dir}/${run_file_name}/${all_cells}  \
     data_module.max_length=4096 \
     trainer.pooling_method=3 \
     batch_column_name=Gender \
     checkpoint=${work_dir}/${run_file_name}/${run_file_name}/epoch10step49345val_loss067.ckpt





pooling=Cond_COL_e10

all_cells=predict_allalpha_${pooling}

bmfm-targets-run -cn predict_finetune_ACTsW2_condW2_SW1_grl_CLS_24_11 \
     input_file=$MY_DATA_FILE \
     file_name=${run_file_name}_${all_cells} \
     working_dir=${work_dir}/${run_file_name}/${all_cells}  \
     data_module.max_length=4096 \
     trainer.pooling_method=2 \
     checkpoint=${work_dir}/${run_file_name}/${run_file_name}/epoch10step49345val_loss067.ckpt


echo "All done"

