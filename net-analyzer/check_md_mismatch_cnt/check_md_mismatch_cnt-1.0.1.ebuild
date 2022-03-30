# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Nagios/Icinga compatible check plugin for software raid (mdadm) mismatch_cnt"
HOMEPAGE="https://github.com/antonfischl1980/check_md_mismatch_cnt"
SRC_URI="https://github.com/antonfischl1980/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install(){
	default

	exeinto /usr/lib64/nagios/plugins/contrib/
	doexe check_md_mismatch_cnt.sh

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	doins check_md_mismatch_cnt.conf
}
