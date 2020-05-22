# Copyright 2014-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="datrie is an implementation of double-array structure for representing trie, as proposed by Junichi Aoe."
HOMEPAGE="https://linux.thai.net/projects/datrie"
SRC_URI="https://linux.thai.net/pub/thailinux/software/libthai/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"

src_configure() {
	econf --disable-static
}
