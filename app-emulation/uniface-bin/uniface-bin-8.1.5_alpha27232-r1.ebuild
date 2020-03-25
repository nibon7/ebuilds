# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils rpm xdg-utils gnome2-utils

MY_PV=${PV/_alpha/-alpha.}

DESCRIPTION="ksvd-client User Tools for Linux Clients"
HOMEPAGE="https://www.kylinos.com.cn"
SRC_URI="
	uniface/uniface-${MY_PV}.x86_64.rpm
	openssl-libs-1.0.2k.tar.xz
"

KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	dev-libs/libusb-compat
	app-crypt/mit-krb5
	dev-libs/dbus-glib
	x11-libs/gtk+:2
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	app-emulation/virt-viewer
	net-misc/networkmanager
"

DEPEND=""
BDEPEND=""

QA_PRESTRIPPED="
	usr/lib/ksvd_client/bin/ksvdusbsrvd
	usr/lib/ksvd_client/lib/libksvdusbapi.so
	usr/lib/ksvd_client/lib/libcrypto.so.1.0.2k
	usr/lib/ksvd_client/lib/libssl.so.1.0.2k
"
QA_DESKTOPFILE="usr/share/applications/ksvd-client.desktop"

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

	# move so files to libdir
	mv ${UNIFACE_HOME}/bin/*.so* ${UNIFACE_HOME}/lib || die

	rm -f usr/bin/uniface || die
	cat >> usr/bin/uniface << EOF
#!/bin/sh
UNIFACE_HOME=/usr/lib/ksvd_client
env LD_LIBRARY_PATH=\${UNIFACE_HOME}/lib \${UNIFACE_HOME}/bin/uniface \$@
EOF

	# fix desktop file
	sed -i 's/Applications;//g' usr/share/applications/ksvd-client.desktop

	# fix permission
	fperms u+s /${UNIFACE_HOME}/bin/super_exec || die
	fperms go+w /etc/uniface || die
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
