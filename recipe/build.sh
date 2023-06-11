#!/bin/bash
set -ex

if [[ "${target_platform}" == "osx-arm64" ]]
then
    export ARCHFLAGS="-arch arm64"
    env
    which python
    $PYTHON --version
    $PYTHON -m pip install . -vv --no-build-isolation --config-settings=setup-args=--cross-file=$PWD/meson-cross.ini
else
    $PYTHON -m pip install . -vv --no-build-isolation $SUFFIX
fi
