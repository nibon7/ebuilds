# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils pax-utils unpacker xdg-utils

TYPORA_LANGS="am ar bg bn ca cs da de el en-GB es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw
	ta te th tr uk vi zh-CN zh-TW"

for lang in ${TYPORA_LANGS}; do
	IUSE+=" +l10n_${lang}"
done

MY_PN=${PN%-bin}

DESCRIPTION="Typora is a cross-platform minimal markdown editor, providing seamless experience for both markdown readers and writers."
HOMEPAGE="https://typora.io"
BASE_URI="https://typora.io/linux"
SRC_URI="${BASE_URI}/${MY_PN}_${PV}_amd64.deb"

RESTRICT="mirror strip bindist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"

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

	for lang in ${TYPORA_LANGS}; do
		if ! use l10n_${lang}; then
			rm -fr usr/share/typora/locales/${lang}.pak || die
		fi
	done

	rm -fr usr/share/lintian || die
	rm -fr usr/share/typora/resources/app/Docs/DO\ NOT\ ADD\ FILES\ HERE || die
	rm -fr usr/share/typora/DO\ NOT\ ADD\ FILES\ HERE.md || die

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
