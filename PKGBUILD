# Maintainer: Dennis Soong <dso2ng@gmail.com>
_realname=mongo-c-driver
pkgbase=mingw-w64-${_realname}
pkgname="${MINGW_PACKAGE_PREFIX}-libmongoc"
source gitver.sh && pkgver=$(get_latest_release mongodb/${_realname})
pkgdesc="libmongoc is a client library written in C for MongoDB. (mingw-w64)"
pkgrel=1
arch=('any')
license=('Apache')
url="http://mongoc.org/libmongoc/current/index.html"
groups=('libraries')
makedepends=('curl' 'git' \
             "${MINGW_PACKAGE_PREFIX}-gcc" \
             "${MINGW_PACKAGE_PREFIX}-cmake" \
             "${MINGW_PACKAGE_PREFIX}-pkg-config")
depends=("${MINGW_PACKAGE_PREFIX}-libbson=${pkgver}")
options=('!strip' '!buildflags' '!makeflags' 'staticlibs')
source=("https://github.com/mongodb/${_realname}/releases/download/${pkgver}/mongo-c-driver-${pkgver}.tar.gz"
        gitver.sh
        01-libmongoc-pkgconfig-libs-fix.patch)
sha256sums=('c2c94ef63aaa09efabcbadc4ac3c8740faa102266bdd2559d550f1955b824398'
            '6ca05c0671ef7ba1716c6e1e7c3fe7852db78929b0efe84d1babe9f49c49eb21'
            '610e5d9cb0d1cc0c4cb072426215f0ce1b3ae6438856da40e098423f540e28c0')
prepare() {
  _srcpath=${srcdir}/${_realname}-${pkgver}
  cd ${_srcpath}
  patch -p1 -i ${srcdir}/01-libmongoc-pkgconfig-libs-fix.patch
}

build() {
  echo starting build...
  echo current directory: $PWD
  echo _srcpath: ${_srcpath}
  _buildpath="${srcdir}/build-${MINGW_CHOST}"
  echo _buildpath: ${_buildpath}
  
  [[ -d "${_buildpath}" ]] && rm -rf "${_buildpath}"
  mkdir -p "${_buildpath}"
  cd "${_buildpath}"

  MSYS2_ARG_CONV_EXCL="-DCMAKE_INSTALL_PREFIX=;-DCMAKE_PREFIX_PATH" \
  ${MINGW_PREFIX}/bin/cmake \
    -G"MSYS Makefiles" \
    "-DENABLE_SSL=WINDOWS" \
    "-DENABLE_SASL=SSPI" \
    "-DCMAKE_INSTALL_PREFIX=${MINGW_PREFIX}" \
    "-DCMAKE_PREFIX_PATH=${MINGW_PREFIX}" \
    "-DCMAKE_BUILD_TYPE=Release" \
    "-DENABLE_TESTS=OFF" \
    "-DENABLE_STATIC=ON" \
    "-DENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF" \
    ${_srcpath}

  make CFLAGS="$CFLAGS -Wall -Wno-char-subscripts -Wno-unused -Wno-pointer-sign -Wno-uninitialized"
}

package() {
  cd ${_buildpath}
  make DESTDIR=${pkgdir} install
}
# vim:set ts=2 sw=2 et:
