#!/bin/bash

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_allcellstype_raw_minimal_codinggenes_condition_alpha_satu_L5Osplit_split.h5ad
work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/predict_biomed/ACT_raw/


#MLM+RDA
run_file_name=ACT_raw_MLM_RDA_01_01
bmfm-targets-run -cn predict input_file=$MY_DATA_FILE file_name=$run_file_name working_dir=${work_dir}/${run_file_name}/ data_module.collation_strategy=language_modeling ++data_module.rda_transform=auto_align data_module.log_normalize_transform=false data_module.max_length=4096 checkpoint=ibm-research/biomed.rna.bert.110m.mlm.rda.v1
echo done

#MLM+Multitask
run_file_name=ACT_raw_MLM_Multitask_01_01
bmfm-targets-run -cn predict input_file=$MY_DATA_FILE file_name=$run_file_name working_dir=${work_dir}/${run_file_name}/ data_module.max_length=4096 checkpoint=ibm-research/biomed.rna.bert.110m.mlm.multitask.v1
echo done

#WCED+Multitask
run_file_name=ACT_raw_WCED_Multitask_01_01
bmfm-targets-run -cn predict input_file=$MY_DATA_FILE file_name=$run_file_name working_dir=${work_dir}/${run_file_name}/ checkpoint=ibm-research/biomed.rna.bert.110m.wced.multitask.v1
echo done

#WCED
run_file_name=ACT_raw_WCED_01_01
bmfm-targets-run -cn predict input_file=$MY_DATA_FILE file_name=$run_file_name working_dir=${work_dir}/${run_file_name}/ data_module.collation_strategy=language_modeling checkpoint=ibm-research/biomed.rna.bert.110m.wced.v1
echo done