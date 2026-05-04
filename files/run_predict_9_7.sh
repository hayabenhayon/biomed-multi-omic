#!/bin/bash

export MY_DATA_FILE=/sci/backup/dandanbz/haya.benhayon/IBM/Seurat/all_celltypes/run6_from_start_with_metadata_allcelltypes_minimal_codinggenes.h5ad
work_dir=/sci/backup/dandanbz/haya.benhayon/IBM/predict_biomed/wced_9_7/

bmfm-targets-run -cn predict input_file=$MY_DATA_FILE working_dir=$work_dir data_module.collation_strategy=language_modeling checkpoint=ibm-research/biomed.rna.bert.110m.wced.v1
