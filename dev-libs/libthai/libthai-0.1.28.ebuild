# Copyright 2014-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Thai language support library"
HOMEPAGE="https://linux.thai.net/projects/libthai"
SRC_URI="https://linux.thai.net/pub/thailinux/software/libthai/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"

DEPEND="dev-libs/libdatrie"
RDEPEND="${DEPEND}"

src_configure() {
	econf --disable-static
}
