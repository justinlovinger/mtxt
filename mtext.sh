#!/bin/bash
send=1
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
    -nosend)
      send=0
      shift
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

  printf "%s" "$1" >> "$bodyf"
  shift
  if [[ $# -gt 0 ]]; then
    printf " %s" "$@" >> "$bodyf"
  fi

  if [[ $send = 1 ]]; then
    opts+=("-send")
  fi
  mcom -body "$bodyf" "${opts[@]}"

  rm "$bodyf"
else
  mcom "${opts[@]}"
fi
