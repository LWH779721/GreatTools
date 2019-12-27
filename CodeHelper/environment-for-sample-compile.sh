#!/bin/bash

PLATFORM_BIN=`pwd`
PLATFORM=${PLATFORM_BIN}/..

export PATH=${PATH}:${PLATFORM_BIN}
export C_INCLUDE_PATH=${C_INCLUDE_PATH}:${PLATFORM}/include   #for c include path
export CPLUS_INCLUDE_PATH=${CPLUS_INCLUDE_PATH}:${PLATFORM}/include  #for c++ include path
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${PLATFORM}/libs  #for library .so
export LIBRARY_PATH=${LIBRARY_PATH}:${PLATFORM}/libs  #for static library