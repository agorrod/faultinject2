#!/bin/sh

public_symbols_txt=$1

cat <<EOF
/*
 * Name mangling for public symbols is controlled by --with-mangling and
 * --with-faultinject-prefix.  With default settings the fi_ prefix is stripped by
 * these macro definitions.
 */
#ifndef FAULTINJECT_NO_RENAME
EOF

for nm in `cat ${public_symbols_txt}` ; do
  n=`echo ${nm} |tr ':' ' ' |awk '{print $1}'`
  m=`echo ${nm} |tr ':' ' ' |awk '{print $2}'`
  echo "#  define fi_${n} ${m}"
done

cat <<EOF
#endif
EOF
