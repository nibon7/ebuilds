# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

MY_PN="Flask-Bootstrap"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Packages Bootstrap into an extension that mostly consists of a blueprint named 'bootstrap'"
HOMEPAGE="https://pypi.python.org/pypi/Flask-Bootstrap"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
>=dev-python/flask-0.10[${PYTHON_USEDEP}]
dev-python/dominate[${PYTHON_USEDEP}]
dev-python/visitor[${PYTHON_USEDEP}]
"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"
