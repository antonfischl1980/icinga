# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KEYWORDS="~amd64"
DESCRIPTION="maps network topology and displays realtime status of Icinga 2 Networks"
HOMEPAGE="https://github.com/visgence/icinga2-dependency-module"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/visgence/icinga2-dependency-module.git"
	EGIT_COMMIT="${PV}"
else
	MY_PN="icinga2-dependency-module"
	MY_P="$MY_PN-$PV"
	SRC_URI="https://github.com/visgence/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_P}"
fi

if [ "${PVR}" == "1.0.0-r1" ]; then
	PATCHES="$FILESDIR/bugfixes-20211111.patch"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	net-analyzer/icinga2
	www-apps/icingaweb2
	"
RDEPEND="${DEPEND}"

src_install() {
	insinto "/usr/share/icingaweb2/modules/dependency_plugin/"
	doins -r "${S}"/*
}
