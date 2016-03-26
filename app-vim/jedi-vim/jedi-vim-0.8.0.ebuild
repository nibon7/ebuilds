# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=(python2_7 python3_{3,4})
inherit python-r1

DESCRIPTION="Awesome Python autocompletion with VIM"
HOMEPAGE="https://github.com/davidhalter/jedi-vim"
SRC_URI="https://github.com/davidhalter/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3+"
KEYWORDS="amd64 x86"
SLOT="0"

RDEPEND="dev-python/jedi[${PYTHON_USEDEP}]"

src_install() {
	insinto /usr/share/vim/vimfiles/
	doins -r  jedi_vim.py initialize.py after autoload doc ftplugin plugin
	dodoc AUTHORS.txt CONTRIBUTING.md LICENSE.txt README.rst
}
