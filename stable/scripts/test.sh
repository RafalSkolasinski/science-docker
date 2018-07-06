#!/bin/bash

set -e

cd /src
start.sh py.test $@
