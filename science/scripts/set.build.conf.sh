#!/bin/bash

source activate science

cp /environments/build.conf /src
sed -i -e "s:PREFIX:$CONDA_PREFIX:g" /src/build.conf
