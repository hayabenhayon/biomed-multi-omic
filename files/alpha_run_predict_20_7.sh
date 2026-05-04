#!/bin/bash

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/Alpha_T1D_healthy/binned_vs_continues/run4_alpha_cells_RNA_metadata_codinggenes.h5ad
work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/predict_biomed/alpha/alpha_MLM_Multitask_20_7/

bmfm-targets-run -cn predict input_file=$MY_DATA_FILE working_dir=$work_dir data_module.max_length=4096 checkpoint=ibm-research/biomed.rna.bert.110m.mlm.multitask.v1
echo done