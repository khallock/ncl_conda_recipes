#!/bin/sh

export CC=${PREFIX}/bin/gcc
export CXXFLAGS="-fPIC"
export LDFLAGS="-L${PREFIX}/lib"
export CPPFLAGS="-I${PREFIX}/include"
export CFLAGS="-I${PREFIX}/include"

if [ "$(uname)" = "Darwin" ]; then
    if [ -d "/opt/X11" ]; then
        x11_lib="-L/opt/X11/lib"
        x11_inc="-I/opt/X11/include -I/opt/X11/include/freetype2"
    else
        echo "No X11 libs found. Exiting..." 1>&2
        exit
    fi
fi
     

echo "/*
 *  This file was created by the Configure script.
 */

#ifdef FirstSite

#endif /* FirstSite */

#ifdef SecondSite

#define YmakeRoot ${PREFIX}

#define LibSearch ${x11_lib} -L${PREFIX}/lib -Wl,-rpath,${PREFIX}/lib
#define IncSearch ${x11_inc} -I${PREFIX}/include -I${PREFIX}/include/freetype2

#define BuildGDAL 1

#endif /* SecondSite */" > config/Site.local

echo -e "n\n" | ./Configure
make Everything

ACTIVATE_DIR="$PREFIX/etc/conda/activate.d"
DEACTIVATE_DIR="$PREFIX/etc/conda/deactivate.d"

mkdir -p "$ACTIVATE_DIR"
mkdir -p "$DEACTIVATE_DIR"

cp "$RECIPE_DIR/scripts/activate.sh" "$ACTIVATE_DIR/ncl-activate.sh"
cp "$RECIPE_DIR/scripts/deactivate.sh" "$DEACTIVATE_DIR/ncl-deactivate.sh"
