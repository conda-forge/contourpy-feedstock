#!/bin/bash
set -ex

EXTRAS=""

if [[ $CONDA_BUILD_CROSS_COMPILATION == "1" ]]
then
    EXTRAS="--config-settings=setup-args=--cross-file=$PWD/meson-cross.ini"
fi

ls -l

$PYTHON -m pip install . -vv --no-build-isolation $EXTRAS
