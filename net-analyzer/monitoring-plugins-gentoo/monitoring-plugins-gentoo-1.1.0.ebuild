# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="icinga/nagios check plugins specific for gentoo"
HOMEPAGE="https://github.com/antonfischl1980/monitoring-plugins-gentoo/"
SRC_URI="https://github.com/antonfischl1980/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~hppa sparc x86"

DEPEND=""
RDEPEND="${DEPEND}
	dev-perl/Time-Duration
	dev-perl/TimeDate
	dev-perl/Monitoring-Plugin
	"
BDEPEND=""

src_install(){
	default

	exeinto /usr/lib64/nagios/plugins/
	doexe *.pl

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	doins *.conf
}
