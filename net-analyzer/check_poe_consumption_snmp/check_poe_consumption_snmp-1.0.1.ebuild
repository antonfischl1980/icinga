# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Nagios/Icinga check for PoE capable Switches implementing POWER-ETHERNET-MIB"
HOMEPAGE="https://github.com/antonfischl1980/check_poe_consumption_snmp"
SRC_URI="https://github.com/antonfischl1980/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND="${DEPEND}
	app-shells/bash
	net-analyzer/net-snmp
	virtual/awk
	"
BDEPEND=""

src_install(){
	default

	exeinto /usr/lib64/nagios/plugins/contrib/
	doexe "${PN}".sh

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	doins "${PN}".conf

	insinto /usr/share/icingaweb2/modules/graphite/templates/
	doins "${PN}".ini
}
