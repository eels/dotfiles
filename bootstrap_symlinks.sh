#!/bin/zsh

# -----------------------------------------------
#   Author: Liam Howell
#   Description: Handles installation of symlinks
#
#   1. VARIABLES
#   2. FUNCTIONS
# -----------------------------------------------

# -----------------------------------------------
#   1. VARIABLES
# -----------------------------------------------

## Global state shared between pipeline functions during config processing
TRIM_LINE=
SRC=
DEST=

# -----------------------------------------------
#   2. FUNCTIONS
# -----------------------------------------------

## Trim whitespace, expand variables, and extract source/destination from a single config line
function parse_line() {
  local line="$1"

  line="${line## }"
  line="${line%% }"
  TRIM_LINE="$line"

  [ -z "$TRIM_LINE" ] && return 1

  eval "parts=($line)"
  SRC="${parts[0]}"
  DEST="${parts[1]}"
}

## Verify the source path exists before attempting to link
function source_exists() {
  [ -e "$SRC" ]
}

## Create the parent directory of the destination path if it does not exist
function ensure_parent_dir() {
  mkdir -p "$(dirname "$DEST")"
}

## Create the symlink and print a status line
function create_symlink() {
  ln -sf "$SRC" "$DEST"
  echo "✓ $SRC → $DEST"
}

## Read every line from the config file and pass it through the symlink pipeline
function process_config() {
  local config="$1"

  while read -r line; do
    parse_line "$line" || continue
    source_exists || continue
    ensure_parent_dir
    create_symlink
  done < "$config"
}

## Entry point. Accepts an optional path to the config file
function main() {
  local config="${1:-.symlinks}"

  process_config "$config"
}

main "$@"
