#!/bin/bash

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/Alpha_T1D_healthy/binned_vs_continues/run4_alpha_cells_RNA_metadata_codinggenes_hvg1024.h5ad
work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/predict_biomed/alpha/alpha_WCED_hvg1024_20_8/





bmfm-targets-run -cn predict_real input_file=$MY_DATA_FILE working_dir=$work_dir data_module.collation_strategy=language_modeling checkpoint=ibm-research/biomed.rna.bert.110m.wced.v1
echo done