# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Monitoring plugin to check the status of nextcloud security scan for a given URL"
HOMEPAGE="https://github.com/janvonde/check_nextcloud/"
SRC_URI="https://github.com/janvonde/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="dev-lang/php"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install(){
	default

	exeinto /usr/lib64/nagios/plugins/contrib/
	doexe ${PN}.php

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	doins ${FILESDIR}/${PN}.conf
}
