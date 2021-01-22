# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit git-r3

DESCRIPTION="double-pinyin input for rime"
HOMEPAGE="https://github.com/rime/rime-double-pinyin"

EGIT_REPO_URI="https://github.com/rime/rime-double-pinyin.git"
EGIT_COMMIT="69bf85d4dfe8bac139c36abbd68d530b8b6622ea"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64 ppc ppc64 x86"
IUSE=""

RDEPEND="app-i18n/rime-data"

src_install() {
	insinto /usr/share/rime-data
	doins -r *.yaml

	dodoc AUTHORS LICENSE README.md
}
