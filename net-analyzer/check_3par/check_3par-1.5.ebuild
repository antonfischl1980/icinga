# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Basic support for monitoring HP 3PAR arrays by Nagios"
HOMEPAGE="https://github.com/qaxi/nagios-check_3par"
EGIT_REPO_URI="https://github.com/qaxi/nagios-check_3par.git"
EGIT_COMMIT="${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

src_install(){
	default
	exeinto /usr/lib64/nagios/plugins/contrib/
	doexe "${PN}"

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	doins ${FILESDIR}/check_3par.conf
}
