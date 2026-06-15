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
DEST=
SRC=
TRIM_LINE=

# -----------------------------------------------
#   2. FUNCTIONS
# -----------------------------------------------

## Trim whitespace, expand variables, and extract source/destination from a single config line
function parse_line() {
  local line="$1"

  line="${line#"${line%%[! ]*}"}"
  line="${line%"${line##*[! ]}"}"
  TRIM_LINE="$line"

  [ -z "$TRIM_LINE" ] && return 1
  [[ "$TRIM_LINE" == '#'* ]] && return 1

  line="${line//\$PWD/$PWD}"
  line="${line//\$HOME/$HOME}"
  DEST="${line#* }"
  DEST="${DEST## }"
  SRC="${line%% *}"
}

## Check if both source and destination paths end with /* (glob pattern)
function has_glob_pattern() {
  [[ "$SRC" == *'/*' ]]
}

## Process a glob pattern line by iterating over children of the source directory
function process_glob_pattern() {
  local entry
  local dest_dir="${DEST%'/*'}"
  local src_dir="${SRC%'/*'}"

  [[ -d "$src_dir" ]] || return 0

  for entry in "$src_dir"/*(ND); do
    local basename="${entry##*/}"

    SRC="$entry"
    DEST="$dest_dir/$basename"

    process_single_file
  done
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

## Process a single file line by ensuring the source exists, creating the parent directory, and creating the symlink
function process_single_file() {
  source_exists || return 0
  ensure_parent_dir
  create_symlink
}

## Read every line from the config file and pass it through the symlink pipeline
function process_config() {
  while read -r line; do
    parse_line "$line" || continue
    has_glob_pattern && process_glob_pattern || process_single_file
  done < "$1"
}

## Entry point. Accepts an optional path to the config file
function main() {
  process_config "${1:-.symlinks}"
}

main "$@"
