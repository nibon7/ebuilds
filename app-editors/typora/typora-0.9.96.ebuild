# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CHROMIUM_LANGS="am ar bg bn ca cs da de el en-GB es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw
	ta te th tr uk vi zh-CN zh-TW"

inherit chromium-2 eutils gnome2-utils pax-utils unpacker xdg-utils

DESCRIPTION="Typora is a cross-platform minimal markdown editor, providing seamless experience for both markdown readers and writers."
HOMEPAGE="https://typora.io"
BASE_URI="https://typora.io/linux"
SRC_URI="${BASE_URI}/${PN}_${PV}_amd64.deb"

RESTRICT="mirror strip bindist"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	gnome-base/gconf
	x11-libs/cairo
	x11-libs/gtk+
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

	rm -r usr/share/lintian || die
	mv usr/share/doc/${PN} usr/share/doc/${PF} || die
	sed -i '/Change Log/d' usr/share/applications/${PN}.desktop || die

	pushd usr/share/${PN}/locales >/dev/null || die
	chromium_remove_language_paks
	popd >/dev/null || die

	# fix permissions
	for f in chokidar/node_modules/fsevents/build/Release/fse.node \
		pathwatcher/build/Release/pathwatcher.node \
		spellchecker/build/Release/spellchecker.node \
		spellchecker/node_modules/cld/build/Release/cld.node \
		spellchecker/vendor/hunspell_dictionaries/en_GB.aff \
		spellchecker/vendor/hunspell_dictionaries/en_GB.dic \
		spellchecker/vendor/hunspell_dictionaries/en_US.aff \
		spellchecker/vendor/hunspell_dictionaries/en_US.dic \
		vscode-ripgrep/bin/rg;
	do
		fperms go-w /usr/share/typora/resources/app/node_modules/${f} || die
	done

	pax-mark m "usr/share/${PN}/Typora"
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
