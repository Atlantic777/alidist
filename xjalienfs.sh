package: xjalienfs
version: "%(tag_basename)s"
tag: 0.0.1-wip-1
source: https://gitlab.cern.ch/jalien/xjalienfs.git
requires:
 - "OpenSSL:(?!osx)"
 - "osx-system-openssl:(osx.*)"
 - XRootD
 - AliEn-Runtime
 - Python-modules
---
#!/bin/bash -e

# env PYTHONUSERBASE="$INSTALLROOT" pip3 install --user -r alibuild_requirements.txt
env PYTHONUSERBASE="$INSTALLROOT" ALIBUILD=1 pip3 install --user file://${SOURCEDIR}
XJALIENFS_SITEPACKAGES=$(find ${INSTALLROOT} -name site-packages)
ALIEN_PY=$(find ${INSTALLROOT} -name alien.py)
JSPY_PY=$(find ${INSTALLROOT} -name jspy.py)

cp -r $SOURCEDIR/bin $INSTALLROOT/bin
ln -s ${ALIEN_PY} $INSTALLROOT/bin/alien.py
ln -s ${JSPY_PY} $INSTALLROOT/bin/jspy.py
chmod +x $INSTALLROOT/bin/*


# Modulefile
MODULEDIR="$INSTALLROOT/etc/modulefiles"
MODULEFILE="$MODULEDIR/$PKGNAME"
mkdir -p "$MODULEDIR"
cat > "$MODULEFILE" <<EoF
#%Module1.0
proc ModulesHelp { } {
  global version
  puts stderr "ALICE Modulefile for $PKGNAME $PKGVERSION-@@PKGREVISION@$PKGHASH@@"
}
set version $PKGVERSION-@@PKGREVISION@$PKGHASH@@
module-whatis "ALICE Modulefile for $PKGNAME $PKGVERSION-@@PKGREVISION@$PKGHASH@@"
# Dependencies
module load ${PYTHON_VERSION:+Python/$PYTHON_VERSION-$PYTHON_REVISION}                                 \\
            ${PYTHON_MODULES_VERSION:+Python-modules/$PYTHON_MODULES_VERSION-$PYTHON_MODULES_REVISION} \\
            ${ALIEN_RUNTIME_VERSION:+AliEn-Runtime/$ALIEN_RUNTIME_VERSION-$ALIEN_RUNTIME_REVISION}     \\
            ${OPENSSL_ROOT:+-DOPENSSL_ROOT_DIR=$OPENSSL_ROOT}                                          \\
	    ${XROOTD_VERSION:+XRootD/$XROOTD_VERSION-$XROOTD_REVISION}
prepend-path PYTHONPATH $XJALIENFS_SITEPACKAGES
prepend-path PATH $INSTALLROOT/bin
EoF
