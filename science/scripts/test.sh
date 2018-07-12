#!/bin/bash

set -e

cd /src
source activate science

py.test $@
