#!/bin/bash

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_allcellstype_raw_minimal_codinggenes_condition_alpha_satu_sub700_L5Osplit_split_hvg6144.h5ad

work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/CLS_tokens_L5O

run_file_name=finetune_ACTsW2_condW2_SW1_CLS_24_11


for sample in H113  ; do
     bmfm-targets-run -cn  finetune_L5O_ACTsW2_condW2_SW1_grl_CLS_24_11 \
	L5O_sample=$sample \
        file_name=$run_file_name \
        input_file=$MY_DATA_FILE \
        work_path=$work_dir/${run_file_name} \
        ++data_module.rda_transform=auto_align \
        data_module.max_length=4096  \
        data_module.batch_size=8 \
        task.max_epochs=24 \
        hydra.run.dir=${work_dir}/${run_file_name}/${run_file_name} 
      
     echo "Finished $sample"
done

echo "All samples done"