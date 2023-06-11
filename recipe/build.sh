#!/bin/bash
set -ex

if [[ "${target_platform}" == "osx-arm64" ]]
then
    export ARCHFLAGS="-arch arm64"

    # From scipy-feedstock:
    # meson-python already sets up a -Dbuildtype=release argument to meson, so
    # we need to strip --buildtype out of MESON_ARGS or fail due to redundancy
    MESON_ARGS_REDUCED="$(echo $MESON_ARGS | sed 's/--buildtype release //g')"

     # Temporary fix for finding pybind11 for cross-compiling until meson 1.2.0 is released.
    MESON_ARGS_REDUCED="$MESON_ARGS_REDUCED --cross-file=$PWD/meson-cross.ini"

    #env
    #which python
    #$PYTHON --version

    # -wnx flags mean: --wheel --no-isolation --skip-dependency-check
    $PYTHON -m build -w -n -x -Csetup-args=${MESON_ARGS_REDUCED// / -Csetup-args=}
    $PYTHON -m pip install dist/contourpy*.whl
else
    $PYTHON -m pip install . -vv --no-build-isolation
fi
