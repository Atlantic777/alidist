package: XRootD
version: "%(tag_basename)s"
tag: v3.3.6
source: https://github.com/xrootd/xrootd.git
build_requires:
 - CMake
 - "OpenSSL:(?!osx)"
 - ApMon-CPP
 - libxml2
 - MonALISA-gSOAP-client
 - "GCC-Toolchain:(?!osx|slc5)"
---
#!/bin/bash -e
case $ARCHITECTURE in 
  osx*)
    [ ! "X$OPENSSL_ROOT" = X ] || OPENSSL_ROOT=`brew --prefix openssl`
  ;;
esac
cmake "$SOURCEDIR" -DCMAKE_INSTALL_PREFIX=$INSTALLROOT                \
                   -DCMAKE_INSTALL_LIBDIR=$INSTALLROOT/lib            \
                   -DENABLE_CRYPTO=TRUE                               \
                   -DENABLE_PERL=TRUE                                 \
                   -DENABLE_KRB5=FALSE                                \
                   -DENABLE_READLINE=FALSE                            \
                   -DCMAKE_BUILD_TYPE=RelWithDebInfo                  \
                   ${OPENSSL_ROOT:+-DOPENSSL_ROOT_DIR=$OPENSSL_ROOT}  \
                   -DZLIB_ROOT=$ZLIB_ROOT
make ${JOBS:+-j$JOBS}
make install
