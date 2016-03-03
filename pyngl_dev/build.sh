#!/bin/sh

svn_revision=r$(svnversion | grep -o '^[0-9]\+')
build_string=$(echo -n ${svn_revision}_np${NPY_VER}py${PY_VER}_${PKG_BUILDNUM} | tr -d '.')

echo dev > __conda_version__.txt
echo ${build_string} > __conda_buildstr__.txt

export CC=${PREFIX}/bin/gcc
export CXXFLAGS="-fPIC"
export LDFLAGS="-L${PREFIX}/lib"
export CPPFLAGS="-I${PREFIX}/include"
export CFLAGS="-I${PREFIX}/include"
export HAS_CAIRO=1
export F2CLIBS=gfortran
export PNG_PREFIX=${PREFIX}
export NCARG_ROOT=${PREFIX}

if [ "$(uname)" = "Darwin" ]; then
    if [ -d "/opt/X11" ]; then
        x11_lib="-L/opt/X11/lib"
        x11_inc="-I/opt/X11/include -I/opt/X11/include/freetype2"
    else
        echo "No X11 libs found. Exiting..." 1>&2
        exit
    fi
fi
     
cd src
python setup.py install