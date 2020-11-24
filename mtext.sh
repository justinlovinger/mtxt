#!/bin/bash
opts=()

if [[ "$1" = -* ]]; then
  positionals=()

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --)
        shift
        while [[ $# -gt 0 ]]; do
          positionals+=("$1")
          shift
        done
        ;;
      *)
        opts+=("$1")
        shift
        ;;
    esac
  done

  set -- "${positionals[@]}" # restore positional parameters
fi

if [[ $# -gt 0 ]]; then
  bodyf=$(mktemp)
  printf "%s" "$@" > "$bodyf"
  mcom -body "$bodyf" -send "${opts[@]}"
  rm "$bodyf"
else
  mcom "${opts[@]}"
fi
