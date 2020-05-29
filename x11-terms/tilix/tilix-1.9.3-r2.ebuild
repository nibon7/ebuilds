# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit xdg-utils unpacker gnome2-utils

TILIX_LANGS="ak ar ar_MA bg cs de el eo es eu fi fr he hu id it ja ko lt nb_NO
	nl pl pt_BR pt_PT ru sr sv tr uk vi zh_CN zh_Hant zh_TW"

for lang in ${TILIX_LANGS}; do
	IUSE+=" +l10n_${lang}"
done

DESCRIPTION="A tiling terminal emulator for Linux using GTK+ 3"
HOMEPAGE="https://gnunn1.github.io/tilix-web/"
LICENSE="MPL-2.0"

RESTRICT="mirror strip bindist"

SLOT="0"
KEYWORDS="-* ~amd64"

GITHUB_URI="https://github.com/gnunn1"
SRC_URI="${GITHUB_URI}/${PN}/releases/download/${PV}/${PN}.zip -> ${P}.zip"

RDEPEND="
	app-crypt/libsecret
	x11-libs/vte:2.91
	>=x11-libs/gtk+-3.22
	gnome-base/dconf
	dev-libs/libbsd
	x11-libs/libX11
	x11-libs/libXdmcp
	x11-libs/libXau
	x11-libs/libxcb"

S=${WORKDIR}

pkg_pretend() {
	use amd64 || die "${PN} only works on amd64"
}

src_unpack() {
	:
}

src_install() {
	dodir /
	cd "${ED}" || die
	unpacker

	gzip -d usr/share/man/man1/tilix.1.gz || die

	for lang in ${TILIX_LANGS}; do
		if ! use l10n_${lang}; then
			rm -fr usr/share/man/${lang} || die
			rm -fr usr/share/locale/${lang} || die
		fi

		if [[ -e usr/share/man/${lang}/man1/tilix.1.gz ]]; then
			gzip -d usr/share/man/${lang}/man1/tilix.1.gz || die
		fi
	done
}

pkg_preinst() {
	gnome2_schemas_savelist
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
