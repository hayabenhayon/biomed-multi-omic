#!/bin/bash

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_from_start_with_metadata_allcelltypes_minimal_codinggenes_condition_alpha_sub700_split.h5ad

work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/ACTs

run_file_name=ACTs_cond_MLMRDA_3_9

bmfm-targets-run -cn ACTs_cond_grl_MLMRDA_3_9 \
        file_name=$run_file_name \
        input_file=$MY_DATA_FILE \
        work_path=$work_dir \
        ++data_module.rda_transform=auto_align \
        data_module.log_normalize_transform=false \
        checkpoint=ibm-research/biomed.rna.bert.110m.mlm.rda.v1 \
        hydra.run.dir=${work_dir}/${run_file_name}

echo done