#!/bin/bash
# Load conda
. /etc/profile.d/huji-lmod.sh
module load spack miniconda3

source $(dirname $(dirname $(which conda)))/etc/profile.d/conda.sh


# Activate env
conda activate bmfm




export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/biomed-multi-omic/test_patchseq/raw_counts/GSE270484_raw_with_md_12_05.h5ad
work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/finetune_bimed/ACT_l50
run_file_name=ACTsW2_condW2_S2grlW1_MLMRDA_hvg4096_4_12_rawRP_HC2
all_cells=predict_external_ensemble

for sample in H032 H071 H123 H055 H113 H087 H020 H021 H028 H064 H084 H023 ; do
    echo "Running checkpoint from fold $sample on full external set"
    bmfm-targets-run -cn predict_patchseq \
     input_file=${MY_DATA_FILE} \
     working_dir=${work_dir}/${run_file_name}/${all_cells}/${sample} \
     ++data_module.rda_transform=auto_align \
     data_module.log_normalize_transform=false \
     data_module.max_length=4096 \
     checkpoint=${work_dir}/${run_file_name}/${sample}_${run_file_name}/last.ckpt \
     file_name=${all_cells}/${sample}
    echo "Finished $sample"
done
echo "All done — now ensemble the 12 prediction outputs"