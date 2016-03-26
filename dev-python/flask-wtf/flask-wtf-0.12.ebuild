# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{3,4} pypy )

# silly captcha test trying to access things over the network
RESTRICT="test"

inherit distutils-r1

DESCRIPTION="Simple integration of Flask and WTForms, including CSRF, file upload and Recaptcha integration"
HOMEPAGE="http://pythonhosted.org/Flask-WTF/ https://pypi.python.org/pypi/Flask-WTF"
SRC_URI="https://github.com/lepture/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc test"

RDEPEND="dev-python/flask[${PYTHON_USEDEP}]
	>=dev-python/wtforms-1.0.5[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/flask-testing[${PYTHON_USEDEP}]
		dev-python/flask-uploads[${PYTHON_USEDEP}]
		dev-python/speaklater[${PYTHON_USEDEP}]
		dev-python/flask-babel[${PYTHON_USEDEP}] )
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}]
		$(python_gen_cond_dep 'dev-python/werkzeug[${PYTHON_USEDEP}]' python2_7 )
	)"

python_compile_all() {
	use doc && esetup.py build_sphinx
}

python_test() {
	nosetests || die "Tests failed under ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}