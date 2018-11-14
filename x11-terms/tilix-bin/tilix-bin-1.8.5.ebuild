# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit xdg-utils gnome2-utils

DESCRIPTION="A tiling terminal emulator for Linux using GTK+ 3"
HOMEPAGE="https://gnunn1.github.io/tilix-web/"
LICENSE="MPL-2.0"

SLOT="0"
KEYWORDS="~amd64 ~x86"

MY_PN=${PN%-bin}
GITHUB_URI="https://github.com/gnunn1"
SRC_URI="${GITHUB_URI}/${MY_PN}/releases/download/${PV}/${MY_PN}.zip -> ${P}.zip"

RDEPEND="
	x11-libs/vte:2.91
	>=x11-libs/gtk+-3.22
	dev-libs/libbsd
	sys-devel/gcc
	x11-libs/libX11
	x11-libs/libXdmcp
	x11-libs/libXau
	x11-libs/libxcb
	app-crypt/libsecret
	!x11-terms/tilix"


QA_PRESTRIPPED="usr/bin/tilix"
QA_PREBUILT="usr/bin/tilix"

src_unpack() {
	mkdir "${S}" || die
	pushd "${S}"
	unpack ${A}
	popd
}

src_install() {
	doins -r usr || die
	fperms +x /usr/bin/${MY_PN}
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postrm() {
	gnome2_schemas_update
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postinst() {
	gnome2_schemas_update
	gnome2_icon_cache_update
	xdg_desktop_database_update
	elog "If you have issues with configuration,follow the offical guide in"
	elog "https://gnunn1.github.io/tilix-web/manual/vteconfig"
}
