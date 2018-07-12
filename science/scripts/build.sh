#!/bin/bash

set -e

cd /src
source activate science

python setup.py build
pip install -e .
