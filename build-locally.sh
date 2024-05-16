#!/usr/bin/env bash

set -euxo pipefail

# Requirements:
# 1. https://zmk.dev/docs/development/setup
# 2. checkout zmk repo to feat/pointers-move-scroll on petejohansson's repo

build_and_copy () {
    local side=$1
    west build \
        -p
        -b nice_nano_v2 -- \
        -DSHIELD=charybdis_$side \
        -DZMK_CONFIG="/Users/pierrevanrooyen/Documents/PvT/zmk/fresh/config"

    cp "./build/zephyr/zmk.uf2" "$CURRENT_DIR/build/charybdis_$side.uf2"
}

CURRENT_DIR="$(pwd)"
CONFIG_DIR="$(pwd)/config"

DEFAULTZMKAPPDIR="$HOME/Documents/PvT/zmk/fresh/zmk/app"
ZMK_APP_DIR="${1:-$DEFAULTZMKAPPDIR}"

mkdir -p $CURRENT_DIR/build

pushd $ZMK_APP_DIR

build_and_copy left
build_and_copy right

popd

