# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils pax-utils xdg-utils

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
BASE_URI="https://vscode-update.azurewebsites.net/${PV}"
SRC_URI="
	x86? ( ${BASE_URI}/linux-ia32/stable ->  ${P}-x86.tar.gz )
	amd64? ( ${BASE_URI}/linux-x64/stable -> ${P}-amd64.tar.gz )
	"
RESTRICT="mirror strip bindist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
	app-crypt/libsecret
	media-libs/libpng:0/16
	>=x11-libs/gtk+-2.24.8-r1:2
	x11-libs/cairo
	gnome-base/gconf
"

QA_PRESTRIPPED="opt/${PN}/code"
QA_PREBUILT="opt/${PN}/code"

pkg_setup(){
	use amd64 && S="${WORKDIR}/VSCode-linux-x64" || S="${WORKDIR}/VSCode-linux-ia32"
}

src_install(){
	pax-mark m code
	insinto "/opt/${PN}"
	doins -r *
	fperms +x "/opt/${PN}/code"
	fperms +x "/opt/${PN}/bin/code"
	fperms +x "/opt/${PN}/libnode.so"
	fperms +x "/opt/${PN}/libffmpeg.so"
	doicon resources/app/resources/linux/code.png
	domenu "${FILESDIR}"/code.desktop
	dosym "/opt/${PN}/bin/code" "/usr/bin/code"
	dodoc "resources/app/LICENSE.txt"
}

pkg_postinst(){
	xdg_desktop_database_update
	elog "You may install some additional utils, so check them in:"
	elog "https://code.visualstudio.com/Docs/setup#_additional-tools"
}

pkg_postrm(){
	xdg_desktop_database_update
}