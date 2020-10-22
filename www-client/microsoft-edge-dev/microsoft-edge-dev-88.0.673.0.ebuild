# Copyright 2011-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

CHROMIUM_LANGS="af am ar as az be bg bn bn-IN bs ca ca-Es-VALENCIA chr cs cy eu
	da de el en-GB es es-419 et fa fi fil fr fr-CA ga gd gl gu he hi hr hu id it
	ja hy is ka kk km kn ko kok ky lb lo lt lv mi mk ml mn mr ms mt nb ne nl nn
	or or pa pl prs pt-BR pt-PT qu ro sd si sq sr-Cyrl-BA sr-Latn-RS tk tt ru sk
	sl sr sv sw ta te th tr ug uk ur uz-Latn vi zh-CN zh-TW"

inherit chromium-2 eutils gnome2-utils pax-utils unpacker xdg-utils

DESCRIPTION="The web browser from Microsoft"
HOMEPAGE="https://www.microsoftedgeinsider.com/"

if [[ ${PN} == microsoft-edge ]]; then
	KEYWORDS="-* amd64"
	MY_PN=${PN}-stable
else
	KEYWORDS="-* ~amd64"
	MY_PN=${PN}
fi

MY_P="${MY_PN}_${PV}-1"

SRC_URI="https://packages.microsoft.com/repos/edge/pool/main/m/${MY_PN}/${MY_P}_amd64.deb"

LICENSE="microsoft-edge"
SLOT="0"
IUSE=""
RESTRICT="bindist mirror strip"

DEPEND=""
RDEPEND="
	app-accessibility/at-spi2-atk:2
	app-arch/bzip2
	app-misc/ca-certificates
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	>=dev-libs/nss-3.26
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype:2
	net-print/cups
	sys-apps/dbus
	sys-libs/libcap
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3[X]
	>=x11-libs/libX11-1.5.0
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/libxcb
	x11-libs/pango
	x11-misc/xdg-utils
"

QA_PREBUILT="*"
QA_DESKTOP_FILE="usr/share/applications/microsoft-edge.*\\.desktop"
S=${WORKDIR}
EDGE_HOME="opt/microsoft/msedge-dev"

pkg_pretend() {
	# Protect against people using autounmask overzealously
	use amd64 || die "microsoft-edge only works on amd64"
}

pkg_setup() {
	chromium_suid_sandbox_check_kernel_config
}

src_unpack() {
	:
}

src_install() {
	dodir /
	cd "${ED}" || die
	unpacker

	rm -r etc usr/share/menu _gpgorigin || die
	mv usr/share/doc/${MY_PN} usr/share/doc/${PF} || die
	mv usr/share/appdata usr/share/metainfo || die

	gzip -d usr/share/doc/${PF}/changelog.gz || die
	gzip -d usr/share/man/man1/${MY_PN}.1.gz || die
	if [[ -L usr/share/man/man1/microsoft-edge.1.gz ]]; then
		rm usr/share/man/man1/microsoft-edge.1.gz || die
		dosym ${MY_PN}.1 usr/share/man/man1/microsoft-edge.1
	fi

	pushd "${EDGE_HOME}/locales" > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die

	local suffix=
	[[ ${PN} == microsoft-edge-beta ]] && suffix=_beta
	[[ ${PN} == microsoft-edge-dev ]] && suffix=_dev

	local size
	for size in 16 24 32 48 64 128 256 ; do
		newicon -s ${size} "${EDGE_HOME}/product_logo_${size}${suffix}.png" ${PN}.png
	done

	pax-mark m "${EDGE_HOME}/msedge"
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
