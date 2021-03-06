#!/bin/bash
# Copyright 2015 Google Inc. All Rights Reserved.
# Licensed under the Apache License, Version 2.0 (the "License");

export PATH=$HOME/llvm-inst/bin:$PATH
P=$(cd $(dirname $0) && pwd)
COMMON=$P/../common

BUCKET=gs://font-fuzzing-corpora
CORPUS=CORPORA/C1
MAX_LEN=4096
MAX_TOTAL_TIME=7200
ARTIFACTS=CORPORA/ARTIFACTS
BUILD_SH=$P/build.sh

SAN=-fsanitize=address
COV=-fsanitize-coverage=edge,8bit-counters
USE_COUNTERS=1


TARGET_NAME=harfbuzz

update_trunk() {
  if [ -d harfbuzz ]; then
    (cd harfbuzz && git pull)
  else
    git clone https://github.com/behdad/harfbuzz.git
  fi
}

source $COMMON/loop_body.sh
