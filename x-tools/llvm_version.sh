#!/bin/bash
ROOT=$(cd `dirname $0` && pwd)
source $ROOT/base/var.sh
echo "$LLVM_VERSION"| sed 's/\./_/g'