# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Nagios/Centreon/Icinga plugin for nextcloud serverinfo API"
HOMEPAGE="https://github.com/BornToBeRoot/check_nextcloud"
EGIT_REPO_URI="https://github.com/BornToBeRoot/check_nextcloud.git"
EGIT_COMMIT="b7e57558ead1511bab83922a97180a7f27760fef"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/01-fix-perfdata.patch"
	)

src_install(){
	default

	exeinto /usr/lib64/nagios/plugins/contrib/
	doexe check/check_nextcloud.py

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	doins "${FILESDIR}/${PN}.conf"

	insinto /usr/share/icingaweb2/modules/graphite/templates/
	doins "${FILESDIR}/${PN}.ini"
}
