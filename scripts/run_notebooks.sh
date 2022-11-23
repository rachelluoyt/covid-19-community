#!/bin/bash

# This script updates the covid-19-community knowledge graph
 
LOGDIR=/notebooks/dataprep/2022-11-20

# enable conda in bash (see: https://github.com/conda/conda/issues/7980)
eval "$(conda shell.bash hook)"

# create conda environment
conda env remove -n covid-19-community &>> $LOGDIR/update.log
conda env create -f environment.yml &>> $LOGDIR/update.log
conda activate covid-19-community &>> $LOGDIR/update.log

# run Jupyter Notebooks to download, clean, and standardize data for the knowledge graph
# To check for any errors, look at the executed notebooks in the $LOGDIR directory

for f in 01h-CORDLineages.ipynb 
do 
  echo "Processing $f file.."
  papermill $f "$LOGDIR"/$KG_output
done

# deactivate conda environment
conda deactivate &>> $LOGDIR/update.log
