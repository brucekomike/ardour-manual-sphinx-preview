#!/usr/bin/env bash
if [[ -z "$1" ]]; then
  echo "Usage: $0 <archive-name>"
  exit 1
fi
if [[ -d "archives" ]]; then
  :
else
  mkdir -p archives
fi
git archive HEAD --prefix=$1/ -o archives/$1.tar.gz
