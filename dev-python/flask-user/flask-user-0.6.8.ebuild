# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

MY_PN="Flask-User"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Customizable User Account Management for Flask: Register, Confirm email, Login, Change username, Change password, Forgot password and more"
HOMEPAGE="https://pypi.python.org/pypi/Flask-User"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	>=dev-python/passlib-1.6[${PYTHON_USEDEP}]
	>=dev-python/bcrypt-0.4[${PYTHON_USEDEP}]
	>=dev-python/pycrypto-2.6[${PYTHON_USEDEP}]
	>=dev-python/flask-0.10[${PYTHON_USEDEP}]
	>=dev-python/flask-wtf-0.12[${PYTHON_USEDEP}]
	>=dev-python/flask-login-0.2[${PYTHON_USEDEP}]
	>=dev-python/flask-mail-0.9[${PYTHON_USEDEP}]
	>=dev-python/flask-sqlalchemy-1.0[${PYTHON_USEDEP}]"
DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"
