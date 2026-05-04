#!/bin/bash

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_allcellstype_rawRP_minimal_codinggenes_condition_alpha_satu_L5Osplit_split_HC2_sub700_hvg6144.h5ad
2
work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/ACT_l50

run_file_name=ACTsW2_condW2_S2grlW1_MLMRDA_hvg4096_4_12_rawRP_HC2

for sample in H071 H064 H020 ; do
    bmfm-targets-run -cn finetune_l5O_ACTsW2_condW2_S2grlW1_MLMRDA_hvg4096_19_11_raw \
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