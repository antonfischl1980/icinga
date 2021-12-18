# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="nagios-icinga-openvpn"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Nagios/Icinga check for OpenVPN availability monitoring"
HOMEPAGE="https://github.com/liquidat/nagios-icinga-openvpn"
SRC_URI="https://github.com/liquidat/nagios-icinga-openvpn/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

DOCS="COPYING AUTHORS README.md"

src_install(){
	default

	exeinto /usr/lib64/nagios/plugins/contrib/
	doexe bin/check_openvpn

	insinto /usr/share/icinga2/include/plugins-contrib.d/
	doins "${FILESDIR}/${PN}.conf"
}
