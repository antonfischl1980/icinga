# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Nagios plugin to check docker containers"
HOMEPAGE="https://github.com/FLiPp3r90/check_docker"
COMMIT="c32f8f40943e0e052cdf2843c0f99d3652be1153"
SRC_URI="https://github.com/FLiPp3r90/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install(){
	default

	exeinto /usr/lib64/nagios/plugins/
	doexe check_docker/check_docker.py

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	doins "${FILESDIR}/${PN}.conf"

	insinto /etc/sudoers.d/
	newins "${FILESDIR}/${PN}.sudo" "${PN}"

	insinto /usr/share/icingaweb2/modules/graphite/templates/
	doins "${FILESDIR}/${PN}.ini"
}
