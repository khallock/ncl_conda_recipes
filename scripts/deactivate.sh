#!/bin/bash
if [ -z $OLD_NCARG_ROOT ]; then
    unset NCARG_ROOT
else
    export NCARG_ROOT=$OLD_NCARG_ROOT
fi
