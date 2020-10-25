# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop gnome2-utils xdg-utils unpacker

DESCRIPTION="fcitx-baidupinyin is a wrapper of Baidu Pinyin IM engine for Fcitx."
HOMEPAGE="https://srf.baidu.com/site/guanwang_linux/index.html"
SRC_URI="https://imeres.baidu.com/imeres/ime-res/guanwang/img/Ubuntu_Deepin-${PN}-64.zip"

LICENSE="baidu-linux-im"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RESTRICT="mirror strip bindist"

RDEPEND="
	>=app-i18n/fcitx-4.2.8
	>=dev-libs/glib-2.62
	>=dev-qt/qtcore-5.10
	>=dev-qt/qtwidgets-5.10
	>=dev-qt/qtquickcontrols-5.10
"

S=${WORKDIR}

pkg_pretend() {
	use amd64 || die "${PN} only works on amd64"
}

src_install() {
	dodir /
	cd "${ED}" || die

	# unpack deb package
	unpack_deb "${S}/${PN}.deb"

	# remove useless files
	rm "${PN}.deb" || die
	rm -r usr/lib || die

	local libdir=$(get_libdir)
	local BDPY_HOME=opt/apps/com.baidu.${PN}

	# make symlinks
	dosym ../../${BDPY_HOME}/files/lib/libbaiduiptcore.so /usr/${libdir}/libbaiduiptcore.so
	dosym ../../${BDPY_HOME}/files/lib/libconfparsor.so /usr/${libdir}/libconfparsor.so
	dosym ../../../${BDPY_HOME}/files/lib/${PN}.so /usr/${libdir}/fcitx/${PN}.so

	dosym /${BDPY_HOME}/entries/applications/fcitx-ui-baidu-qimpanel.desktop /etc/xdg/autostart/fcitx-ui-baidu-qimpanel.desktop
	dosym /${BDPY_HOME}/entries/applications/fcitx-ui-baidu-qimpanel.desktop /usr/share/applications/fcitx-ui-baidu-qimpanel.desktop
	dosym /${BDPY_HOME}/entries/locale/zh_CN/LC_MESSAGES/${PN}.mo /usr/share/locale/zh_CN/LC_MESSAGES/${PN}.mo

	local size
	for size in 16 48;
	do
		doicon -s ${size} ${BDPY_HOME}/entries/icons/hicolor/${size}x${size}/apps/${PN}.png
	done

	# fix permission
	for f in ${PN}.so libbaiduiptcore.so  libconfparsor.so;
	do
		fperms a+x /${BDPY_HOME}/files/lib/${f}
	done
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
