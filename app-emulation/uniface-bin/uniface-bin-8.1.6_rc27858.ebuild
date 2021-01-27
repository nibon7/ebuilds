# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils rpm xdg-utils gnome2-utils

MY_PV=${PV/_rc/-rc.}

DESCRIPTION="ksvd-client User Tools for Linux Clients"
HOMEPAGE="http://www.kylinsec.com.cn"
SRC_URI="
	uniface/uniface-${MY_PV}.x86_64.rpm
	openssl-libs-1.0.2k.tar.xz
"

KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	>=dev-libs/libusb-compat-0.1.5-r2
	>=app-crypt/mit-krb5-1.18.2-r2
	>=x11-libs/gtk+-2.24.32:2
	>=dev-qt/qtcore-5.15.2:5
	>=dev-qt/qtwidgets-5.15.2:5
	>=dev-qt/qtgui-5.15.2:5
	>=dev-qt/qtnetwork-5.15.2:5
	>=app-emulation/virt-viewer-8.0
	>=net-misc/networkmanager-1.26.4
"

S="${WORKDIR}"

pkg_pretend() {
	use amd64 || die "this ebuild only support amd64"
}

src_unpack() {
	:
}

src_install() {
	cd "${ED}" || die
	dodir / || die
	rpm_src_unpack "${A}"

	local UNIFACE_HOME="usr/lib/ksvd_client"

	rm -f ${UNIFACE_HOME}/lib/libuniface.so || die
	dosym libuniface.so.1 ${UNIFACE_HOME}/lib/libuniface.so

	# install bundled ssl libs
	mv *.so* ${UNIFACE_HOME}/lib || die

	rm -f usr/bin/uniface || die
	cat >> usr/bin/uniface << EOF
#!/bin/sh
UNIFACE_HOME=/usr/lib/ksvd_client
env LD_LIBRARY_PATH=\${UNIFACE_HOME}/lib:\${LD_LIBRARY_PATH} \\
	\${UNIFACE_HOME}/bin/uniface \$@
EOF

	# fix desktop file
	sed -i 's/Applications;//g' usr/share/applications/ksvd-client.desktop

	# fix permission
	fperms a+x /usr/bin/uniface || die
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
