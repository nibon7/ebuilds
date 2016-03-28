# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )
inherit python-r1

MY_PN="jedi-vim"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Awesome Python autocompletion with VIM"
HOMEPAGE="https://github.com/davidhalter/jedi-vim"
SRC_URI="https://github.com/davidhalter/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="LGPL-3+"
KEYWORDS="amd64 x86"
SLOT="0"

RDEPEND="dev-python/jedi[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

src_install() {
	insinto /usr/share/vim/vimfiles/
	doins -r  jedi_vim.py initialize.py after autoload doc ftplugin plugin
	dodoc AUTHORS.txt CONTRIBUTING.md LICENSE.txt README.rst
}
