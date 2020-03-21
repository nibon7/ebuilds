# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils pax-utils unpacker xdg-utils

MY_PN=${PN%-bin}

DESCRIPTION="Typora is a cross-platform minimal markdown editor, providing seamless experience for both markdown readers and writers."
HOMEPAGE="https://typora.io"
BASE_URI="https://typora.io/linux"
SRC_URI="${BASE_URI}/${MY_PN}_${PV}_amd64.deb"

RESTRICT="mirror strip bindist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RDEPEND="
	gnome-base/gconf
	x11-libs/cairo
	x11-libs/gtk+
"
QA_PREBUILT="*"
QA_DESKTOP_FILE="usr/share/applications/typora.desktop"
S="${WORKDIR}"

pkg_pretend() {
	use amd64 || die "this ebuild only support amd64"
}

src_unpack() {
	:
}

src_install(){
	dodir /
	cd "${ED}" || die
	unpacker

	rm -fr usr/share/lintian || die

	mv usr/share/doc/typora usr/share/doc/${PF} || die

	sed -i '/Change Log/d' usr/share/applications/typora.desktop || die

	pax-mark m "usr/share/typora/Typora"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}
