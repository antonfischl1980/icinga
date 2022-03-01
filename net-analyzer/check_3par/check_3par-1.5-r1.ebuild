# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="nagios-${PN}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Basic support for monitoring HP 3PAR arrays by Nagios"
HOMEPAGE="https://github.com/qaxi/nagios-check_3par"
SRC_URI="https://github.com/qaxi/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

src_install(){
	default
	exeinto /usr/lib64/nagios/plugins/contrib/
	doexe "${PN}"

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	doins "${FILESDIR}/check_3par.conf"
}
