#!/bin/bash

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_from_start_with_metadata_allcelltypes_minimal_codinggenes_condition_alpha_sub700_split.h5ad

work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/ACTs_gridsearch


#run_file_name=ACTsW5_condW5_SgrlW1_MLMRDA_3_9
run_file_name=ACTsW2_condW2_SgrlW1_MLMRDA_3_9

for grl in 1 2 1.5 0; do
    bmfm-targets-run -cn ACTsW_condW_SgrlW_MLMRDA_3_9 \
        gradient_reversal_coefficient=$grl \
        file_name=$run_file_name \
        input_file=$MY_DATA_FILE \
        work_path=$work_dir \
        ++data_module.rda_transform=auto_align \
        data_module.log_normalize_transform=false \
        checkpoint=ibm-research/biomed.rna.bert.110m.mlm.rda.v1 \
        hydra.run.dir=${work_dir}/${grl}_${run_file_name}

    echo " Finished $grl"
done
echo done