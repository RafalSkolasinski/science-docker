#!/bin/bash

set -e

cd /src
py.test $@
