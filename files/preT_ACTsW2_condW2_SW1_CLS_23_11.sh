#!/bin/bash

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_allcellstype_raw_minimal_codinggenes_condition_alpha_satu_sub700_L5Osplit_split.h5ad

work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/pretrained_biomed/CLS_tokens

run_file_name=preT_ACTsW2_condW2_SW1_CLS_23_11

bmfm-targets-run -cn  preT_ACTsW2_condW2_SW1_CLS_23_11 \
        file_name=$run_file_name \
        input_file=$MY_DATA_FILE \
        work_path=$work_dir \
        data_module.max_length=4096  \
        max_epochs=10 \
        hydra.run.dir=${work_dir}/${run_file_name}/${run_file_name} 
echo done
