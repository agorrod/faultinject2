#!/bin/sh

objroot=$1

cat <<EOF
#ifndef FAULTINJECT_H_
#define	FAULTINJECT_H_
#ifdef __cplusplus
extern "C" {
#endif

EOF

for hdr in faultinject_defs.h faultinject_rename.h faultinject_macros.h \
           faultinject_protos.h faultinject_mangle.h ; do
  cat "${objroot}include/faultinject/${hdr}" \
      | grep -v 'Generated from .* by configure\.' \
      | sed -e 's/^#define /#define	/g' \
      | sed -e 's/ $//g'
  echo
done

cat <<EOF
#ifdef __cplusplus
};
#endif
#endif /* FAULTINJECT_H_ */
EOF
