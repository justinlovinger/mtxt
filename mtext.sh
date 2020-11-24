#!/bin/bash
opts=()
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
    -*)
      opts+=("$1" "$2")
      shift
      shift
      ;;
    *)
      positionals+=("$1")
      shift
      ;;
  esac
done

set -- "${positionals[@]}" # restore positional parameters

if [[ $# -gt 0 ]]; then
  bodyf=$(mktemp)
  printf "%s" "$@" > "$bodyf"
  mcom -body "$bodyf" -send "${opts[@]}"
  rm "$bodyf"
else
  mcom "${opts[@]}"
fi
