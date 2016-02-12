#!/bin/bash
if [ ! -z $NCARG_ROOT ]; then
    export OLD_NCARG_ROOT=$NCARG_ROOT
fi

export NCARG_ROOT="$(cd ${_PREFIX} && pwd)"
