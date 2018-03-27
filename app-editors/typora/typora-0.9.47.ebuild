# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils pax-utils xdg-utils

MY_PN="${PN^}"

DESCRIPTION="Typora is a cross-platform minimal markdown editor, providing seamless experience for both markdown readers and writers."
HOMEPAGE="https://typora.io"
BASE_URI="https://typora.io/linux"
SRC_URI="
	x86? ( ${BASE_URI}/${MY_PN}-linux-ia32.tar.gz ->  ${P}-linux-x86.tar.gz )
	amd64? ( ${BASE_URI}/${MY_PN}-linux-x64.tar.gz -> ${P}-linux-amd64.tar.gz )
	"
RESTRICT="mirror strip bindist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	gnome-base/gconf
	x11-libs/cairo
	x11-libs/gtk+
"

RDEPEND="
	${DEPEND}
"

QA_PRESTRIPPED="opt/${PN}/${MY_PN}"
QA_PREBUILT="opt/${PN}/${MY_PN}"

pkg_setup(){
	use amd64 && S="${WORKDIR}/${MY_PN}-linux-x64" || S="${WORKDIR}/${MY_PN}-linux-ia32"
}

src_install(){
	pax-mark m "${MY_PN}"
	insinto "/opt/${PN}"
	doins -r *
	dosym "/opt/${PN}/${MY_PN}" "/usr/bin/${PN}"
	doicon "${FILESDIR}/${PN}.png"
	domenu "${FILESDIR}/${PN}.desktop"
	fperms +x "/opt/${PN}/${MY_PN}"
	fperms +x "/opt/${PN}/libffmpeg.so"
	fperms +x "/opt/${PN}/libnode.so"
}

pkg_postinst(){
	xdg_desktop_database_update
}

pkg_postrm(){
	xdg_desktop_database_update
}
