#!/bin/bash

set -euo pipefail

if [ $# -ne 1 ]
then
  echo "Only pass one project name"
  exit 1
fi

echo "######################################## Syncing $@"
cd $@
hub reset --hard
hub checkout master
hub remote add upstream bazelbuild/$@ || \
  hub remote add upstream google/$@ || \
  hub remote add upstream grpc/$@ || \
  hub remote add upstream envoyproxy/$@ || \
  hub sync
hub push
