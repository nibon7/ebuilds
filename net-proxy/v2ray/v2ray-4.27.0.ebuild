# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit golang-base systemd

MY_PN="${PN}-core"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A platform for building proxies to bypass network restrictions"
HOMEPAGE="https://www.v2ray.com/"
SRC_URI="https://github.com/v2ray/v2ray-core/archive/v${PV}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	export GOCACHE="${T}/go-cache"
	export CGO_ENABLED=0
	export BUILDNAME=$(date '+%Y%m%d-%H%M%S')
	export LDFLAGS="-s -w -X v2ray.com/core.codename=${PN} -X v2ray.com/core.build=${BUILDNAME} -X v2ray.com/core.version=${PV}"

	go build -o bin/v2ray -ldflags "${LDFLAGS}" v2ray.com/core/main || die
	go build -o bin/v2ctl -tags confonly -ldflags "${LDFLAGS}" v2ray.com/core/infra/control/main || die
}


src_install() {
	dobin bin/v2ray
	dobin bin/v2ray

	pushd release/config || die
	sed -i 's#/usr/bin/v2ray/v2ray#/usr/bin/v2ray#g' \
		systemd/v2ray.service \
		systemd/v2ray@.service || die

	systemd_dounit systemd/v2ray.service
	systemd_dounit systemd/v2ray@.service

	insinto /usr/share/v2ray
	doins *.dat

	insinto /etc/v2ray
	doins *.json
	popd

	dodoc README.md
	newinitd "${FILESDIR}/v2ray.initd" v2ray
}
