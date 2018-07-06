#!/bin/bash

set -e

cd /src
. activate && conda activate science

python setup.py build
pip install -e .
