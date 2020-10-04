# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils pax-utils xdg-utils

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
BASE_URI="https://vscode-update.azurewebsites.net/${PV}"
SRC_URI="amd64? ( ${BASE_URI}/linux-x64/stable -> ${P}-amd64.tar.gz )"
RESTRICT="mirror strip bindist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

DEPEND=">=gnome-base/gconf-3.2.6-r4:2
	>=media-libs/libpng-1.2.46:0
	>=x11-libs/cairo-1.14.12:0
	>=x11-libs/gtk+-2.24.31-r1:2
	>=x11-libs/libXtst-1.2.3:0
"
RDEPEND="
	${DEPEND}
	>=net-print/cups-2.1.4:0
	>=x11-libs/libnotify-0.7.7:0
	>=x11-libs/libXScrnSaver-1.2.2-r1:0
	dev-libs/nss
	app-crypt/libsecret[crypt]
"

QA_PRESTRIPPED="opt/${PN}/code"
QA_PREBUILT="opt/${PN}/code"

pkg_setup(){
	use amd64 && S="${WORKDIR}/VSCode-linux-x64"
}

src_install(){
	pax-mark m code
	insinto "/opt/${PN}"
	doins -r *
	fperms +x "/opt/${PN}/code"
	fperms +x "/opt/${PN}/bin/code"
	fperms +x "/opt/${PN}/libffmpeg.so"
	fperms +x "/opt/${PN}/resources/app/node_modules.asar.unpacked/vscode-ripgrep/bin/rg"
	doicon resources/app/resources/linux/code.png
	domenu "${FILESDIR}"/code.desktop
	dosym "../../opt/${PN}/bin/code" "/usr/bin/code"
	dodoc "resources/app/LICENSE.rtf"
}

pkg_postinst(){
	xdg_desktop_database_update
	elog "You may install some additional utils, so check them in:"
	elog "https://code.visualstudio.com/Docs/setup#_additional-tools"
}

pkg_postrm(){
	xdg_desktop_database_update
}
