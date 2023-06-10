#!/bin/bash
set -ex

EXTRAS=""
if [[ $CONDA_BUILD_CROSS_COMPILATION == "1" ]]
then
    EXTRAS='--config-settings=setup-args=--cross-file="$SRC_DIR/meson-cross.ini"'
fi

$PYTHON -m pip install . -vv --no-build-isolation $EXTRAS
