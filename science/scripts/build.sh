#!/bin/bash

set -e

cd /src
python setup.py build
pip install -e .
