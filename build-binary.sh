#!/usr/bin/env bash

set -euo pipefail

LUA_FILE=$1
NAME=$(basename "$1" .lua)
STATIC_LUA_LIB=/usr/lib/x86_64-linux-gnu/liblua5.3.a
LUA_INCLUDE_DIR=/usr/include/lua5.3
shift

antifennel "${LUA_FILE}" > "${NAME}.fnl"
fennel --compile --require-as-include "${NAME}.fnl" > "tmp.lua"
luastatic "tmp.lua" "$STATIC_LUA_LIB" "-I${LUA_INCLUDE_DIR}"
mv "tmp" "${NAME}"
rm "${NAME}.fnl" "tmp.lua" "tmp.luastatic.c"
