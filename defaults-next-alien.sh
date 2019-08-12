package: defaults-next-alien
version: v1
disable:
  - arrow
env:
  CXXFLAGS: "-fPIC -g -O2 -std=c++11"
  CFLAGS: "-fPIC -g -O2"
  CMAKE_BUILD_TYPE: "RELWITHDEBINFO"
overrides:
  AliEn-ROOT-Legacy:
    tag: "0.1.0-beta-1"
    build_requires:
      - xalienfs
      - Alice-GRID-Utils
  AliPhysics:
    version: "%(tag_basename)s_NEXT_ALIEN"
    tag: vAN-20190811
  AliRoot:
    version: "%(tag_basename)s_NEXT_ALIEN"
    source: https://github.com/atlantic777/aliroot
    tag: v5-09-50_JALIEN-03
    requires:
      - ROOT
      - DPMJET
      - fastjet:(?!.*ppc64)
      - GEANT3
      - GEANT4_VMC
      - Vc
      - AliEn-ROOT-Legacy
---
# This file is included in any build recipe and it's only used to set
# environment variables. Which file to actually include can be defined by the
# "--defaults" option of alibuild.

