#!/bin/bash

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_from_start_with_metadata_allcelltypes_minimal_codinggenes_condition_alpha_sub700_split.h5ad

work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/pretrained_biomed/CLS_tokens

run_file_name=preT_ACTsW2_condW2_SW1_CLS_4_11_test

bmfm-targets-run -cn  preT_ACTsW2_condW2_SW1_CLS_4_11 \
        file_name=$run_file_name \
        input_file=$MY_DATA_FILE \
        work_path=$work_dir \
        data_module.max_length=4096  \
        max_epochs=10 \
        track_clearml.continue_last_task=e336f0bd6df44d56903d4493cd6a739c \
        checkpoint=${work_dir}/${run_file_name}/last.ckpt \
        hydra.run.dir=${work_dir}/${run_file_name}/${run_file_name}_resume
echo done
