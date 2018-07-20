#!/bin/bash

set -e

cd /src
source activate base

py.test $@
