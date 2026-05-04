#!/bin/bash

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_from_start_with_metadata_allcelltypes_minimal_codinggenes_condition_alpha_sub700_L5Osplit.h5ad

work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/ACT_l50

run_file_name=ACTs_cond_S2grl_MLMRDA_14_9

for sample in H113  H023 H021  ; do
    bmfm-targets-run -cn finetune_l5O_ACTs_cond_Sgrl_MLMRDA_14_9 \
        L5O_sample=$sample \
        gradient_reversal_coefficient=2 \
        file_name=$run_file_name \
        input_file=$MY_DATA_FILE \
        work_path=$work_dir/${run_file_name} \
        ++data_module.rda_transform=auto_align \
        data_module.log_normalize_transform=false \
        checkpoint=ibm-research/biomed.rna.bert.110m.mlm.rda.v1 \
        hydra.run.dir=${work_dir}/${run_file_name}/${sample}_${run_file_name}

    echo " Finished $sample"
done
echo done