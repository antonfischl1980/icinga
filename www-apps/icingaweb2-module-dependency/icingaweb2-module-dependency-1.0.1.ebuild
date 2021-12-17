# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

KEYWORDS="amd64"
DESCRIPTION="maps network topology and displays realtime status of Icinga 2 Networks"
HOMEPAGE="https://github.com/visgence/icinga2-dependency-module"
EGIT_REPO_URI="https://github.com/visgence/icinga2-dependency-module.git"
if [[ "${PV}" == "1.0.1" ]]; then
	EGIT_COMMIT="719547efa86bfe55d581a4e5ccedcee00e1a0d5d"
elif [[ "${PV}" != 9999 ]]; then
	EGIT_COMMIT="${PV}"
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
