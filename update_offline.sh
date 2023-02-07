#!/usr/bin/bash

# variables
PATH="/home/greystone/locchuong" #/home/greystone/GG_Non_Phone/ML_MODULE
MYENV="myenv" # env_main_app
MYCONDA="myconda" # miniconda3_py38
WHEELS="/home/greystone/locchuong/wheels"
CONDA="${PATH}/${MYCONDA}/bin/conda" # /home/greystone/GG_Non_Phone/ML_MODULE/miniconda3_py38/bin/conda
ENV="${PATH}/${MYCONDA}/envs/${MYENV}" # /home/greystone/GG_Non_Phone/ML_MODULE/miniconda3_py38/envs/miniconda3_py38
PIP="${PATH}/${MYCONDA}/envs/${MYENV}/bin/pip" # /home/greystone/GG_Non_Phone/ML_MODULE/miniconda3_py38/envs/miniconda3_py38/bin/pip

# check miniconda3 installation
if [ -f "$CONDA" ]; then
    echo "Miniconda3 is installed"
else
    echo "Miniconda3 is NOT installed"
    #exit bash script
    exit 1 # notify failue
fi

# check conda virtualenv installation
if [ -d "$ENV" ]; then
    echo "${MYENV} is created"
else
    echo "${MYENV} is NOT installed"
    #exit bash script
    exit 1 # notify failue
fi

# loop over wheel files and install
for item in $WHEELS/*.whl
do
    echo "Installing: $item"
    $PIP install $item
done

echo "Done update!"

exit 0 # notify success