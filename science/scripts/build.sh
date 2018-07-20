#!/bin/bash

set -e

cd /src
source activate base

python setup.py build
pip install -e .
