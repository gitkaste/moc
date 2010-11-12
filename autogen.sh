#!/bin/sh

set -x

if test -f Makefile; then
	make distclean >/dev/null 2>/dev/null
fi
if [ `uname` = "Darwin" ]; then
	glibtoolize -c -f
	aclocal -I m4 -I /usr/local/share/aclocal
else
	libtoolize -c -f
	aclocal -I m4 
fi
if [ "$?" = 0 ]; then
	autoheader && \
	automake -W all -a && \
	autoconf -W syntax
fi
if [ "$?" != 0 ]
then
	cat <<EOF
If you see errors it might be necessary to install additional packages like
autoconf >= 2.60
automake >= 1.9
libltdl (libltdl3-dev debian package)
and all -devel packages mentioned in the README file
EOF
fi
