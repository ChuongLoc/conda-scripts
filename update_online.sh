#!/usr/bin/bash

# set variables
MYENV="env" #env_main_app
MYCONDA="myconda" #miniconda3_py38
PACKAGES="/home/greystone/locchuong/packages.txt" #
REQUIREMENTS="/home/greystone/locchuong/requirements.txt"
CONDA="/home/greystone/locchuong/${MYCONDA}/bin/conda"
ENV="/home/greystone/locchuong/${MYCONDA}/envs/${MYENV}"
PIP="/home/greystone/locchuong/${MYCONDA}/envs/${MYENV}/bin/pip"

# check miniconda3 installation
if [ -f "$CONDA" ]; then
    echo "miniconda3 installed"
else
    echo "miniconda3 not installed"
    #exit bash script
    exit 0
fi

# check conda virtualenv
if [ -d "$ENV" ]; then
    echo "${MYENV} is created!"
else
    echo "${MYENV} is creating..."
    $CONDA create -n $MYENV python=3.8
fi

# export current packages
$PIP freeze > $PACKAGES
# remove certifi line in exported text file
python3 filter.py -p $PACKAGES

# set environment variable UPDATE_PACKAGES = False
export UPVAR="working"

# compare requirements vs current packages
if cmp -s "$PACKAGES" "$REQUIREMENTS"; then
    # if packages.txt equal to requirements.txt
    printf 'The file "%s" is the same as "%s",NO UPDATE\n' "$PACKAGES" "$REQUIREMENTS"
else
    # if they are not equal
    printf 'The file "%s" is different from "%s",UPDATING...\n' "$PACKAGES" "$REQUIREMENTS"
    # install new packages
    $PIP install -r $REQUIREMENTS
    # export updated packages list
    $PIP freeze > $PACKAGES
    # remove certifi line in exported text file
    python3 filter.py -p $PACKAGES
fi

# set environment variable UPDATE_PACKAGES = True
export UPVAR="done"