# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils rpm xdg-utils gnome2-utils

MY_PV=${PV/_alpha/-alpha.}

DESCRIPTION="ksvd-client User Tools for Linux Clients"
HOMEPAGE="https://www.kylinos.com.cn"
SRC_URI="
	uniface/${PN}-${MY_PV}.x86_64.rpm
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

QA_PRESTRIPPED="usr/lib/ksvd_client/lib/.*\.so.* usr/lib/ksvd_client/bin/ksvdusbsrvd"

src_unpack() {
	mkdir -p "${S}" || die "failed to create ${S}"
	pushd "${S}"
		rpm_src_unpack "${A}"
	popd
}

src_install() {
	local UNIFACE_HOME_DIR="usr/lib/ksvd_client"

	rm -f ${UNIFACE_HOME_DIR}/lib/libuniface.so
	dosym libuniface.so.1 ${UNIFACE_HOME_DIR}/lib/libuniface.so

	# install bundled ssl libs
	mv libssl.so* libcrypto.so* ${UNIFACE_HOME_DIR}/lib

	# move so files to libdir
	mv ${UNIFACE_HOME_DIR}/bin/*.so* ${UNIFACE_HOME_DIR}/lib

	rm -f usr/bin/uniface

	# fix desktop file
	sed -i 's/Applications;//g' usr/share/applications/ksvd-client.desktop

	doins -r etc
	doins -r usr

	exeinto /usr/bin
	newexe "${FILESDIR}/uniface.sh" uniface

	# fix permission
	fperms -R a+x /${UNIFACE_HOME_DIR}/lib

	for f in ksvdusbsrvd \
		ksvd-leaf-usb-exclusion-filter.sh \
		ksvd-pulseaudio-server \
		ksvd-usb-server \
		spicec \
		spicec.bin \
		uniface;
	do
		fperms a+x /${UNIFACE_HOME_DIR}/bin/${f}
	done

	fperms a+x,u+s /${UNIFACE_HOME_DIR}/bin/super_exec
	fperms go+w /etc/uniface
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
