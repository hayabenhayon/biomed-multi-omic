#!/bin/bash

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_from_start_with_metadata_allcelltypes_minimal_codinggenes_condition_alpha_sub700_L5Osplit.h5ad

work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/ACT_l50/ACT_Cond_MLMRDA_L5O_2_9/

run_file_name=ACT_Cond_MLMRDA_L5O_2_9

bmfm-targets-run -cn finetune_l5O L5O_sample=H113,H087 file_name=$run_file_name input_file=$MY_DATA_FILE working_dir=$work_dir ++data_module.rda_transform=auto_align data_module.log_normalize_transform=false checkpoint=ibm-research/biomed.rna.bert.110m.mlm.rda.v1
echo done