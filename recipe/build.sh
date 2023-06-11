#!/bin/bash
set -ex

if [[ "${target_platform}" == "osx-arm64" ]]
then
    # Cross-compilation using similar approach to scikit-image.
    # Also see https://conda-forge.org/blog/posts/2020-10-29-macos-arm64/
    # about MESON_ARGS and cross file.

    cat $BUILD_PREFIX/meson_cross_file.txt

    # Second cross-file is a temporary fix for finding pybind11 when cross-compiling
    # until meson 1.2.0 is released.
    $PYTHON -m pip install . -vv --no-build-isolation \
        --config-settings=setup-args=--cross-file=$BUILD_PREFIX/meson_cross_file.txt \
        --config-settings=setup-args=--cross-file=$PWD/meson-cross.ini
else
    $PYTHON -m pip install . -vv --no-build-isolation
fi
