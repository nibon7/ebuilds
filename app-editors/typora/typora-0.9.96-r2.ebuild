# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CHROMIUM_LANGS="am ar bg bn ca cs da de el en-GB es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw
	ta te th tr uk vi zh-CN zh-TW"

inherit chromium-2 eutils gnome2-utils pax-utils xdg-utils

MY_PN="${PN^}"

DESCRIPTION="Typora is a cross-platform minimal markdown editor, providing seamless experience for both markdown readers and writers."
HOMEPAGE="https://typora.io"
SRC_URI="${HOMEPAGE}/linux/${MY_PN}-linux-x64.tar.gz -> ${P}-linux-amd64.tar.gz"

RESTRICT="mirror strip bindist"

LICENSE="Typora-EULA"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RDEPEND="
	>=x11-libs/pango-1.42.4-r2
	>=x11-libs/pixman-0.40.0
	>=x11-libs/cairo-1.16.0
	>=x11-libs/gdk-pixbuf-2.40.0
	>=x11-libs/gtk+-3.24.22
"

pkg_pretend() {
	use amd64 || die "${PN} only works on amd64"
}

pkg_setup(){
	S="${WORKDIR}/bin/${MY_PN}-linux-x64"
}

src_install(){
	local TYPORA_HOME="opt/${PN}"

	pushd locales >/dev/null || die
	chromium_remove_language_paks
	popd >/dev/null || die

	dodoc LICENSE LICENSES.chromium.html
	rm -fr LICENSE LICENSES.chromium.html || die

	pax-mark m "${MY_PN}"

	insinto "${TYPORA_HOME}"
	doins -r *

	# fix permissions
	fperms +x "/${TYPORA_HOME}/${MY_PN}"
	fperms +x "/${TYPORA_HOME}/libEGL.so"
	fperms +x "/${TYPORA_HOME}/libGLESv2.so"
	fperms +x "/${TYPORA_HOME}/libffmpeg.so"
	fperms +x "/${TYPORA_HOME}/libvk_swiftshader.so"
	fperms +x "/${TYPORA_HOME}/libvulkan.so"
	fperms 4755 "/${TYPORA_HOME}/chrome-sandbox"

	local size
	for size in 16 32 128 256 512;
	do
		newicon -s ${size} resources/app/asserts/icon/icon_${size}x${size}.png ${PN}.png
	done

	dosym "../../${TYPORA_HOME}/${MY_PN}" "/usr/bin/${PN}"
	domenu "${FILESDIR}/${PN}.desktop"
}

pkg_postinst(){
	gnome2_icon_savelist
}

pkg_postrm(){
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}
