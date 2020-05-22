# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CHROMIUM_LANGS="am ar bg bn ca cs da de el en-GB es es-419 et fa fi fil fr gu he
	hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr
	sv sw ta te th tr uk vi zh-CN zh-TW"

inherit chromium-2 eutils gnome2-utils pax-utils unpacker xdg-utils

DESCRIPTION="Netease cloud music player."
HOMEPAGE="http://music.163.com"
SRC_URI="http://d1.music.126.net/dmusic/netease-cloud-music_${PV}_amd64_ubuntu_20190428.deb"

RESTRICT="mirror strip bindist"

SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	dev-libs/libdatrie
	dev-libs/libthai
	dev-libs/glib
	x11-libs/libxcb
	media-libs/alsa-lib
	media-libs/harfbuzz
	gnome-base/gconf
	x11-libs/pango
"

S="${WORKDIR}"

pkg_pretend() {
	use amd64 || die "${PN} only works on amd64"
}

src_unpack() {
	:
}

src_install(){
	dodir /
	cd "${ED}" || die
	unpacker

	gzip -d usr/share/doc/${PN}/changelog.gz || die
	mv usr/share/doc/${PN} usr/share/doc/${PF} || die

	pushd "opt/netease/${PN}/libs/qcef/locales" > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die
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
