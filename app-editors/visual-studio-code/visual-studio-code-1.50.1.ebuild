# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CHROMIUM_LANGS="am ar bg bn ca cs da de el en-GB es-419 es et fa fil fi fr gu he
	hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr
	sv sw ta te th tr uk vi zh-CN zh-TW"

inherit chromium-2 eutils pax-utils xdg-utils

DESCRIPTION="Code editing. Redefined."
HOMEPAGE="https://code.visualstudio.com"
BASE_URI="https://update.code.visualstudio.com/${PV}"
SRC_URI="amd64? ( ${BASE_URI}/linux-x64/stable -> ${P}-amd64.tar.gz )"
RESTRICT="mirror strip bindist"

LICENSE="microsoft-visual-studio-code"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND=">=gnome-base/gconf-3.2.6-r4:2
	>=media-libs/libpng-1.2.46:0
	>=x11-libs/cairo-1.14.12:0
	>=x11-libs/gtk+-2.24.31-r1:2
	>=x11-libs/libXtst-1.2.3:0
	>=net-print/cups-2.1.4:0
	>=x11-libs/libnotify-0.7.7:0
	>=x11-libs/libXScrnSaver-1.2.2-r1:0
	>=x11-libs/libxkbfile-1.1.0
	dev-libs/nss
	app-crypt/libsecret[crypt]
"

QA_PRESTRIPPED="opt/${PN}/code"
QA_PREBUILT="opt/${PN}/code"

pkg_setup(){
	use amd64 && S="${WORKDIR}/VSCode-linux-x64"
}

src_install(){
	pushd locales >/dev/null || die
	chromium_remove_language_paks
	popd >/dev/null || die

	pax-mark m code

	insinto "/opt/${PN}"
	doins -r *

	# fix permissions
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
