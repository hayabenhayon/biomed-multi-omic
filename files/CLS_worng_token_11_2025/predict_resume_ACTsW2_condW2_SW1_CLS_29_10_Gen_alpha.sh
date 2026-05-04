#!/bin/bash

#export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_from_start_with_metadata_allcelltypes_minimal_codinggenes_condition_alpha_L5Osplit.h5ad
export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_from_start_with_metadata_allcelltypes_minimal_codinggenes_condition_alpha_satu_alpha.h5ad

work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/CLS_tokens

run_file_name=ACTsW2_condW2_SW1_CLS_29_10


pooling=CT
all_cells=predict_allalpha_${pooling}

bmfm-targets-run -cn predict_resume_ACTsW2_condW2_SW1_CLS_29_10 \
     input_file=$MY_DATA_FILE \
     file_name=${run_file_name}_allalpha_resume_${pooling} \
     working_dir=${work_dir}/${run_file_name}_resume/${all_cells}  \
     ++data_module.rda_transform=auto_align \
     data_module.log_normalize_transform=false \
     data_module.max_length=4096 \
     trainer.pooling_method=1 \
     checkpoint=${work_dir}/${run_file_name}/${run_file_name}/last-v1.ckpt 

echo "All done"

exit
=\
pooling=Gen
all_cells=predict_allalpha_${pooling}

bmfm-targets-run -cn predict_resume_ACTsW2_condW2_SW1_CLS_29_10 \
     input_file=$MY_DATA_FILE \
     file_name=${run_file_name}_allalpha_resume_${pooling} \
     working_dir=${work_dir}/${run_file_name}_resume/${all_cells}  \
     ++data_module.rda_transform=auto_align \
     data_module.log_normalize_transform=false \
     data_module.max_length=4096 \
     trainer.pooling_method=3  \
     checkpoint=${work_dir}/${run_file_name}/${run_file_name}/last-v1.ckpt 

pooling=sam
all_cells=predict_allalpha_${pooling}

bmfm-targets-run -cn predict_resume_ACTsW2_condW2_SW1_CLS_29_10 \
     input_file=$MY_DATA_FILE \
     file_name=${run_file_name}_allalpha_resume_${pooling} \
     working_dir=${work_dir}/${run_file_name}_resume/${all_cells}  \
     ++data_module.rda_transform=auto_align \
     data_module.log_normalize_transform=false \
     data_module.max_length=4096 \
     trainer.pooling_method=4 \
     checkpoint=${work_dir}/${run_file_name}/${run_file_name}/last-v1.ckpt 

echo "All done"


