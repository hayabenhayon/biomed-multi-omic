#!/bin/bash

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_allcellstype_raw_minimal_codinggenes_condition_alpha_satu_L5Osplit_split_alpha_hvg6144.h5ad

work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/CLS_tokens_L5O

run_file_name=finetune_ACTsW2_condW2_SW1_CLS_24_11

all_cells=predict_allcells_L5O_hvg4096

pooling=Cond_COL_e24_test

all_cells=predict_allalpha_L5O_hvg4096_${pooling}

for sample in  H087   ; do
    echo "Processing $sample"
    column="L5O_${sample}"   # define the column here in bash


    # Run bmfm on subset
    bmfm-targets-run -cn predict_L5O_ACTsW2_condW2_SW1_grl_CLS_24_11_H087test \
     input_file=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/tmp2.h5ad \
     L5O_sample=$sample \
     working_dir=${work_dir}/${run_file_name}/${all_cells}/${sample}_${run_file_name}  \
     ++data_module.rda_transform=auto_align \
     data_module.log_normalize_transform=false \
     data_module.max_length=4096 \
     trainer.pooling_method=2  \
     checkpoint=${work_dir}/${run_file_name}/${sample}_${run_file_name}/last.ckpt \

    echo "Finished $sample"
done

echo "All done"


