#!/bin/bash

source activate base

cp /environments/build.conf /src
sed -i -e "s:PREFIX:$CONDA_PREFIX:g" /src/build.conf
