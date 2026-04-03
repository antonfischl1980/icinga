# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Icinga check command for Proxmox VE via API"
HOMEPAGE="https://github.com/nbuchwitz/check_pve"
SRC_URI="https://github.com/nbuchwitz/check_pve/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	dev-python/requests
	dev-python/packaging
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install(){
	default_src_install

	exeinto /usr/lib64/nagios/plugins/
	doexe check_pve.py

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	newins icinga2/command.conf "${PN}.conf"

	newdoc icinga2/service.conf example.conf
	dodoc ./*.md
}
