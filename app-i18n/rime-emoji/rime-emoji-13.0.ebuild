# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

DESCRIPTION="Emoji support for rime"
HOMEPAGE="https://github.com/rime/rime-emoji"
SRC_URI="https://github.com/rime/${PN}/archive/${PV}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 arm64 ppc ppc64 x86"
IUSE=""

RDEPEND="app-i18n/rime-data"

src_install() {
	insinto /usr/share/rime-data
	doins -r opencc emoji_suggestion.yaml

	dodoc AUTHORS LICENSE README.md
}
