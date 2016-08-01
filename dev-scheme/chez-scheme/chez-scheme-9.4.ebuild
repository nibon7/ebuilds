# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils

MY_PN="ChezScheme"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Chez Scheme is a compiler and run-time system for the language of the Revised^6 Report on Scheme (R6RS), with numerous extensions."
HOMEPAGE="https://github.com/cisco/chezscheme"
SRC_URI="https://github.com/cisco/ChezScheme/archive/v9.4.tar.gz -> ${MY_P}.tar.gz
  https://github.com/nanopass/nanopass-framework-scheme/archive/221eecb965d9dfacccd97d1cb73f2a31c4119d3a.zip -> nanopass-framework-scheme-221eecb965d9dfacccd97d1cb73f2a31c4119d3a.zip
  https://github.com/dybvig/stex/archive/3bd2b86cc5ae1797d05fc5cc6f11cc43383f741d.zip -> stex-3bd2b86cc5ae1797d05fc5cc6f11cc43383f741d.zip
  https://github.com/madler/zlib/archive/50893291621658f355bc5b4d450a8d06a563053d.zip -> zlib-50893291621658f355bc5b4d450a8d06a563053d.zip
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
	mv ${WORKDIR}/nanopass-framework-scheme-221eecb965d9dfacccd97d1cb73f2a31c4119d3a nanopass
	mv ${WORKDIR}/stex-3bd2b86cc5ae1797d05fc5cc6f11cc43383f741d stex
	mv ${WORKDIR}/zlib-50893291621658f355bc5b4d450a8d06a563053d zlib
}

src_configure() {
	./configure --installprefix=/usr --temproot=${D}
}
