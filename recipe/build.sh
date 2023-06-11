#!/bin/bash
set -ex

if [[ "${target_platform}" == "osx-arm64" ]]
then
    # Cross-compilation using similar approach to scikit-image.
    # Also see https://conda-forge.org/blog/posts/2020-10-29-macos-arm64/ about MESON_ARGS.
    mkdir builddir

    echo ${MESON_ARGS}

     # Temporary fix for finding pybind11 for cross-compiling until meson 1.2.0 is released.
    MESON_ARGS="$MESON_ARGS --cross-file=$PWD/meson-cross.ini"

    echo ${MESON_ARGS}

    ${PYTHON} $(which meson) setup ${MESON_ARGS} builddir

    ${PYTHON} -m build --wheel --no-isolation --skip-dependency-check -Cbuilddir=builddir
    ${PYTHON} -m pip install dist/contourpy*.whl

    # This may not be required...
    #export ARCHFLAGS="-arch arm64"
else
    $PYTHON -m pip install . -vv --no-build-isolation
fi
