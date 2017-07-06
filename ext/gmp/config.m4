dnl
dnl $Id$
dnl

PHP_ARG_WITH(gmp, for GNU MP support,
[  --with-gmp[=DIR]        Include GNU MP support])

if test "$PHP_GMP" != "no"; then

  for i in $PHP_GMP /usr/local /usr; do
    libpath=$(find $i/include -type f -name gmp.h | head -1)
    includedir=$(dirname $libpath)
    test -f $libpath && GMP_DIR=$i && break
  done

  if test -d "$GMP_DIR"; then
    AC_MSG_ERROR(Unable to locate gmp.h)
  fi

  PHP_CHECK_LIBRARY(gmp, __gmp_randinit_lc_2exp_size,
  [],[
    PHP_CHECK_LIBRARY(gmp, gmp_randinit_lc_2exp_size,
    [],[
      AC_MSG_ERROR([GNU MP Library version 4.1.2 or greater required.])
    ],[
      -L$GMP_DIR/$PHP_LIBDIR
    ])
  ],[
    -L$GMP_DIR/$PHP_LIBDIR
  ])

  PHP_ADD_LIBRARY_WITH_PATH(gmp, $GMP_DIR/$PHP_LIBDIR, GMP_SHARED_LIBADD)
  PHP_ADD_INCLUDE($includedir)

  PHP_NEW_EXTENSION(gmp, gmp.c, $ext_shared)
  PHP_SUBST(GMP_SHARED_LIBADD)
  AC_DEFINE(HAVE_GMP, 1, [ ])
fi
