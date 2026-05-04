#!/bin/bash

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/Alpha_T1D_healthy/binned_vs_continues/run4_alpha_cells_RNA_metadata_codinggenes_hvg4096.h5ad
work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/predict_biomed/alpha/alpha_MLM_RDA_hvg4096_20_8/



bmfm-targets-run -cn predict_real input_file=$MY_DATA_FILE working_dir=$work_dir data_module.collation_strategy=language_modeling ++data_module.rda_transform=auto_align data_module.log_normalize_transform=false data_module.max_length=4096 checkpoint=ibm-research/biomed.rna.bert.110m.mlm.rda.v1

echo done