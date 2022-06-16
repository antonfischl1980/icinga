# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="checks if HPE controllers an SSDs are not affected by certain vulnerabilities"
HOMEPAGE="https://github.com/NETWAYS/check_hp_firmware"

SRC_URI="https://github.com/NETWAYS/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://nextcloud.fischl-online.de/s/scCEJMbefrmYgr4/download/${P}-deps.tar.xz
	"

LICENSE="GPL-2 MIT BSD MPL-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install(){
	exeinto /usr/lib64/nagios/plugins/contrib/
	use amd64 && newexe "build/${PN}-amd64" "${PN}"
	use x86 && newexe "build/${PN}-i386" "${PN}"

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	newins icinga2.conf "${PN}".conf
}
