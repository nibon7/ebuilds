# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_PN="ChezScheme"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Chez Scheme is a compiler and run-time system for the language of the Revised^6 Report on Scheme (R6RS), with numerous extensions."
HOMEPAGE="https://github.com/cisco/chezscheme"
SRC_URI="https://github.com/cisco/ChezScheme/archive/v9.4.tar.gz -> ${MY_P}.tar.gz
	https://github.com/nanopass/nanopass-framework-scheme/archive/v1.9.tar.gz -> nanopass-framework-scheme-1.9.tar.gz
	https://github.com/dybvig/stex/archive/v1.2.1.tar.gz -> stex-1.2.1.tar.gz
	https://github.com/madler/zlib/archive/v1.2.8.tar.gz -> zlib-1.2.8.tar.gz
	"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="
  sys-libs/ncurses
  x11-libs/libX11
  "
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	rm -fr nanopass stex zlib
	mv ${WORKDIR}/nanopass-framework-scheme-1.9 nanopass
	mv ${WORKDIR}/stex-1.2.1 stex
	mv ${WORKDIR}/zlib-1.2.8 zlib
}

src_configure() {
	./configure --installprefix=/usr --temproot=${D}
}
